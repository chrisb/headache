module Headache
  module Definition
    module BatchControl
      extend ActiveSupport::Concern

      included do
        include Common

        field :service_code,                 3,   '2-4', :alphanumeric # Field2
        field :entry_count,                  6,  '5-10', :numeric      # Field3
        field :entry_hash,                  10, '11-20', :numeric      # Field4
        field :total_debit,                 12, '21-32', :numeric      # Field5
        field :total_credit,                12, '33-44', :numeric      # Field6
        field :company_identification,      10, '45-54', :alphanumeric # Field7
        field :message_authentication_code, 19, '55-73', :nothing      # Field8
        field :reserved,                     6, '74-79', :nothing      # Field9
        field :odfi_id,                      8, '80-87', :alphanumeric # Field10
        field :batch_number,                 7, '88-94', :numeric      # Field11

        field_value :message_authentication_code, ''
        field_value :reserved, ''
      end
    end
  end
end
