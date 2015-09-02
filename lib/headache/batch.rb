module Headache
  class Batch
    include Enumerable

    attr_accessor :type, :document, :batch_number, :service_code, :odfi_id,
                  :company_name, :company_identification, :effective_date,
                  :company_name, :company_identification, :discretionary,
                  :entry_class_code, :entry_description

    @@record_classes = { header: Record::BatchHeader,
                         control: Record::BatchControl }

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

    def effective_date
      @effective_date || Date.today
    end

    def initialize(document = nil)
      @document = document
      @members  = []
    end

    def service_code
      return '220' if type == :credit
      return '225' if type == :debit
      fail "unknown batch type: #{type.inspect} (expecting :credit or :debit)"
    end

    def header
      @header ||= @@record_classes[:header].new self, @document
    end

    def control
      @control ||= @@record_classes[:control].new self, @document
    end

    def entries
      @members
    end

    def batch_number
      @batch_number || document.batches.index(batch) + 1
    end

    def entry_hash
      entries.map(&:routing_identification).map(&:to_i).sum
    end

    def add_entry(entry)
      entry.batch = self
      @members << entry
    end

    def <<(entry_or_entries)
      [(entries.is_a?(Array) ? entry_or_entries : [entry_or_entries])].flatten.each { |e| add_entry e }
      self
    end

    def method_missing(m, *args, &block)
      entries.send m, *args, &block
    end

    def total_debit
      entries.map(&:amount).select { |amt| amt < 0 }.map(&:abs).sum
    end

    def total_credit
      entries.map(&:amount).select { |amt| amt > 0 }.sum
    end

  end
end
