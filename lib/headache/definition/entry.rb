module Headache
  module Definition
    module Entry
      extend ActiveSupport::Concern

      included do
        include Common

        field :transaction_code,       2,   '2-3', :alphanumeric # Field2
        field :routing_identification, 8,  '4-11', :numeric      # Field3
        field :check_digit,            1, '12-12', :numeric      # Field4
        field :account_number,        17, '13-29', :alphanumeric # Field5
        field :amount,                10, '30-39', :numeric      # Field6
        field :internal_id,           15, '40-54', :alphanumeric # Field7
        field :individual_name,       22, '55-76', :alphanumeric # Field8
        field :discretionary,          2, '77-78', :alphanumeric # Field9
        field :addenda_record,         1, '79-79', :alphanumeric # Field10
        field :trace_number,          15, '80-94', :alphanumeric # Field11

        field_value :addenda_record, '0'
        field_value :discretionary,  ''
      end

      def routing_identification
        routing_number.first 8
      end

      def check_digit
        routing_number.last 1
      end
    end
  end
end
