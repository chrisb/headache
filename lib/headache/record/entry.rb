module Headache
  module Record
    class Entry < Fixy::Record
      include Definition::Entry

      attr_accessor :routing_number, :account_number, :amount,
                    :internal_id, :trace_number, :individual_name,
                    :transaction_code, :document, :batch, :discretionary

      def initialize(batch = nil, document = nil)
        @batch = batch
        @document = document
      end
    end
  end
end
