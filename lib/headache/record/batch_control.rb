module Headache
  module Record
    class BatchControl < Headache::Record::Base
      include Definition::BatchControl

      attr_accessor :batch, :document

      delegate :entry_hash, :batch_number, :total_debit, :total_credit,
               :total_debit=, :total_credit=, :service_code, :odfi_id,
               :company_identification, :entry_hash=, to: :batch

      def initialize(batch, document)
        @batch = batch
        @document = document
      end

      def entry_count
        batch.size
      end
    end
  end
end
