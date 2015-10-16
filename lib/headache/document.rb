module Headache
  class Document < Fixy::Document
    attr_reader :batches

    LINE_SEPARATOR = "\r\n"

    delegate :add_entry, :'<<', to: :first_batch

    @@record_classes = { batch: Batch,
                         header: Record::FileHeader,
                         control: Record::FileControl }

    def self.header=(klass)
      set_class :header, klass
    end

    def self.control=(klass)
      set_class :control, klass
    end

    def self.set_class(type, klass)
      fail "unknown record class: #{type}" unless @@record_classes[type].present?
      @@record_classes[type] = klass
    end

    def initialize
      @batches = []
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

    def lines
      @content.split("\n").count
    end

    def overflow_lines_needed
      10 - lines % 10
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
