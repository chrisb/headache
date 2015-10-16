module Headache
  module Definition
    module BatchControl
      extend ActiveSupport::Concern

      included do
        include Common

        field :service_code,                 3, '2-4',   :alphanumeric
        field :entry_count,                  6, '5-10',  :numeric_value
        field :entry_hash,                  10, '11-20', :numeric
        field :total_debit,                 12, '21-32', :numeric_value
        field :total_credit,                12, '33-44', :numeric_value
        field :company_identification,      10, '45-54', :alphanumeric
        field :message_authentication_code, 19, '55-73', :nothing
        field :reserved,                     6, '74-79', :nothing
        field :odfi_id,                      8, '80-87', :alphanumeric
        field :batch_number,                 7, '88-94', :numeric

        field_value :message_authentication_code, ''
        field_value :reserved, ''
      end
    end
  end
end
