module Headache
  module Definition
    module Common
      extend ActiveSupport::Concern

      included do
        attr_accessor :document

        set_record_length 94
        set_line_ending Fixy::Record::LINE_ENDING_CRLF

        include Formatters

        field :record_type_code, 1, '1-1', :alphanumeric

        def record_type_codes
          { file_header: 1,
           batch_header: 5,
                  entry: 6,
          batch_control: 8,
           file_control: 9 }
        end

        def record_type_code
          record_type = self.class.name.demodulize.underscore
          record_type_codes[record_type.to_sym]
        end
      end
    end
  end
end
