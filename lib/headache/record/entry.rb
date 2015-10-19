module Headache
  module Record
    class Entry < Headache::Record::Base
      include Definition::Entry

      attr_accessor :routing_number, :account_number, :amount,
                    :internal_id, :trace_number, :individual_name,
                    :transaction_code, :document, :batch, :discretionary,
                    :check_digit, :routing_identification

      def check_digit=(value)
        rval = (@check_digit = value)
        assemble_routing_number
        rval
      end

      def routing_identification=(value)
        rval = (@routing_identification = value)
        assemble_routing_number
        rval
      end

      def assemble_routing_number
        if @routing_identification.present? && @check_digit.present?
          @routing_number = "#{@routing_identification}#{@check_digit}"
        end
      end

      def to_h
        new_hsh = {}
        super.each_pair do |key, value|
          next if key == :check_digit
          if key == :routing_identification
            key   = :routing_number
            value = @routing_number
          end
          new_hsh[key] = value
        end
        new_hsh
      end

      def routing_identification
        @routing_identification || routing_number.to_s.first(8)
      end

      def check_digit
        @check_digit || routing_number.to_s.last(1)
      end

      def initialize(batch = nil, document = nil)
        @batch    = batch
        @document = document
      end
    end
  end
end
