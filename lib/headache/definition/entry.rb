module Headache
  module Definition
    module Entry
      extend ActiveSupport::Concern

      included do
        include Common

        field :transaction_code,       2,   '2-3', :alphanumeric
        field :routing_identification, 8,  '4-11', :numeric
        field :check_digit,            1, '12-12', :numeric
        field :account_number,        17, '13-29', :alphanumeric
        field :amount,                10, '30-39', :numeric_value
        field :internal_id,           15, '40-54', :alphanumeric
        field :individual_name,       22, '55-76', :alphanumeric
        field :discretionary,          2, '77-78', :alphanumeric
        field :addenda_record,         1, '79-79', :alphanumeric
        field :trace_number,          15, '80-94', :alphanumeric

        field_value :addenda_record, '0'
        field_value :discretionary,  ''
      end
    end
  end
end
