module Headache
  module Record
    class Base < Fixy::Record
      def self.parse_fields_normalize(record_string)
        parse_fields(record_string).inject({}) { |m,i| m[i.first] = normalize_field_value(i.first, i.last); m }
      end

      def self.parse_fields(record_string)
        parse(record_string)[:fields].inject({}) do |m,i|
          m[i[:name]] = i[:value]; m
        end
      end

      def self.fields
        @record_fields.to_a.map { |i| i.last }.inject({}) { |m,i| m[i[:name]] = i.except(:name); m }
      end

      def self.normalize_field_value(field, value)
        field_type = fields[field].try(:[],:type)
        return value if field_type.nil?

        case field_type
        when :numeric_value
          value.gsub(/^0+/,'').to_i
        when :alphanumeric
          value.strip
        when :nothing
          nil
        else
          value
        end
      end

      def normalize_field_value(f, v)
        self.class.normalize_field_value(f, v)
      end

      def to_h
        str = self.generate.gsub "\r\n", ''
        self.class.parse_fields(str)
      end

      def parse_fields(record_string)
        self.class.parse_fields record_string
      end

      def parse(record_string)
        parse_fields(record_string).each_pair do |field, value|
          if respond_to?("#{field}=")
            send "#{field}=", normalize_field_value(field, value) if respond_to?("#{field}=")
          end
        end
        self
      end
    end
  end
end
