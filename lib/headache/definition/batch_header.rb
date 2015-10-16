module Headache
  module Definition
    module BatchHeader
      extend ActiveSupport::Concern

      included do
        include Common

        field :service_code,            3,   '2-4', :alphanumeric
        field :company_name,           16,  '5-20', :alphanumeric
        field :discretionary,          20, '21-40', :alphanumeric
        field :company_identification, 10, '41-50', :alphanumeric
        field :entry_class_code,        3, '51-53', :alphanumeric
        field :entry_description,      10, '54-63', :alphanumeric
        field :descriptive_date,        6, '64-69', :date
        field :effective_date,          6, '70-75', :date
        field :settlement_date,         3, '76-78', :nothing # inserted by ACH operator
        field :originator_status_code,  1, '79-79', :alphanumeric
        field :odfi_id,                 8, '80-87', :alphanumeric
        field :batch_number,            7, '88-94', :numeric

        field_value :settlement_date,        ''
        field_value :originator_status_code, '1'
      end
    end
  end
end
