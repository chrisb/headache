module Headache
  module Record
    class Overflow < Fixy::Record
      include Formatters

      set_record_length 94
      set_line_ending Fixy::Record::LINE_ENDING_CRLF

      field :overflow, 94, '1-94', :numeric
      field_value :overflow, -> { '9' * 94 }
    end
  end
end
