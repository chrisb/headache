module Headache
  module Definition
    module FileHeader
      extend ActiveSupport::Concern

      included do
        include Common

        field :priority_code,     2,   '2-3', :numeric      # Field2
        field :destination,      10,  '4-13', :alphanumeric # Field3
        field :origin,           10, '14-23', :alphanumeric # Field4
        field :creation_date,     6, '24-29', :date         # Field5
        field :creation_time,     4, '30-33', :time         # Field6
        field :id_modifier,       1, '34-34', :alphanumeric # Field7
        field :record_size,       3, '35-37', :alphanumeric # Field8
        field :blocking_factor,   2, '38-39', :alphanumeric # Field9
        field :format_code,       1, '40-40', :alphanumeric # Field10
        field :destination_name, 23, '41-63', :alphanumeric # Field11
        field :origin_name,      23, '64-86', :alphanumeric # Field12
        field :reference_code,    8, '87-94', :alphanumeric # Field13

        field_value :priority_code,   '01'
        field_value :record_size,     '094'
        field_value :blocking_factor, '10'
        field_value :format_code,     '1'
      end
    end
  end
end
