module Headache
  class Document < Fixy::Document
    attr_reader :batches

    LINE_SEPARATOR = "\r\n"

    delegate :add_entry, :'<<', to: :first_batch

    @@record_classes = { batch: Batch,
                         header: Record::FileHeader,
                         control: Record::FileControl }

    def self.header_class
      @@record_classes[:header]
    end

    def self.control_class
      @@record_classes[:control]
    end

    def self.header=(klass)
      set_class :header, klass
    end

    def self.control=(klass)
      set_class :control, klass
    end

    def self.extract_lines(string_or_file)
      string = string_or_file.respond_to?(:read) ? string_or_file.read : string_or_file
      string.split(LINE_SEPARATOR).reject { |line| line == Headache::Record::Overflow.new.generate.strip }
    end

    def self.cleanse_records(records)
      invalid_lines = records.reject { |line| Headache::Record::FileHeader.record_type_codes.values.include?(line.first.to_i) }
      raise "uknown record type(s): #{invalid_lines.map(&:first).inspect}" if invalid_lines.any?
      records
    end

    def self.parse(string_or_file)
      records = cleanse_records(extract_lines string_or_file)
      header  = header_class.new(nil).parse(records.shift)
      control = control_class.new(nil).parse(records.pop)
      batches = get_batches(records).map { |b| Headache::Batch.new(self).parse(b) }
      new header, control, batches
    end

    def self.get_batches(records)
      batches = []
      batch   = []
      records.each do |line|
        if line.starts_with?(Headache::Record::BatchHeader.record_type_codes[:batch_header].to_s)
          batches << batch unless batches.empty? && batch == []
          batch = [line]
        else
          batch << line
        end
      end
      batches << batch
    end

    def self.set_class(type, klass)
      fail "unknown record class: #{type}" unless @@record_classes[type].present?
      @@record_classes[type] = klass
    end

    def initialize(header = nil, control = nil, batches = [])
      @header  = header
      @control = control
      @batches = batches
      @header.document  = self unless @header.nil?
      @control.document = self unless @control.nil?
    end

    def first_batch
      add_batch @@record_classes[:batch].new(self) if @batches.empty?
      @batches.first
    end

    def batch
      fail 'multiple batches detected, be more explicit or use first_batch' if @batches.count > 1
      first_batch
    end

    def add_batch(batch)
      batch.document = self
      @batches << batch # @@record_classes[:batch].new(self)
    end

    def <<(batch)
      add_batch batch
      self
    end

    def entries
      @batches.map(&:entries).flatten
    end

    def header
      @header ||= @@record_classes[:header].new self
    end

    def control
      @control ||= @@record_classes[:control].new self
    end

    def records
      ([ header ] << batches.map do |batch|
        [ batch.header, batch.entries, batch.control ]
      end << control).flatten # .compact
    end

    def lines
      @content.split("\n").count
    end

    def overflow_lines_needed
      10 - lines % 10
    end

    def to_h
      {  file_header: @header.to_h,
             batches: @batches.map(&:to_h),
        file_control: @control.to_h }
    end

    def build
      append_record header
      @batches.each do |batch|
        append_record batch.header
        batch.entries.each { |entry| append_record entry }
        append_record batch.control
      end
      append_record control
      overflow_lines_needed.times { append_record Record::Overflow.new }
    end

  end
end
