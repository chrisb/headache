module Headache
  module Definition
    module BatchHeader
      extend ActiveSupport::Concern

      included do
        include Common

        field :service_code,            3,   '2-4', :alphanumeric # Field2 credits =  220, debits = 225
        field :company_name,           16,  '5-20', :alphanumeric # Field3
        field :discretionary,          20, '21-40', :alphanumeric # Field4
        field :company_identification, 10, '41-50', :alphanumeric # Field5
        field :entry_class_code,        3, '51-53', :alphanumeric # Field6
        field :entry_description,      10, '54-63', :alphanumeric # Field7
        field :descriptive_date,        6, '64-69', :nothing      # Field8
        field :effective_date,          6, '70-75', :date         # Field9
        field :settlement_date,         3, '76-78', :nothing      # Field10
        field :originator_status_code,  1, '79-79', :alphanumeric # Field11
        field :odfi_id,                 8, '80-87', :alphanumeric # Field12
        field :batch_number,            7, '88-94', :alphanumeric # Field13

        field_value :descriptive_date,       ''
        field_value :settlement_date,        ''
        field_value :originator_status_code, '1'
      end
    end
  end
end
