module Headache
  module Record
    class BatchControl < Headache::Record::Base
      include Definition::BatchControl

      attr_accessor :batch, :document

      delegate :entry_hash, :total_debit, :total_credit, :batch_number,
               :service_code, :odfi_id, :company_identification, to: :batch

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
