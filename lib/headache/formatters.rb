module Headache
  module Formatters
    include Fixy::Formatter::Alphanumeric

    def format_alphanumeric(input, length)
      super(input, length).upcase
    end

    def format_numeric_value(input, length)
      format_numeric(input, length)
    end

    def format_date(input, length)
      if input.respond_to?(:strftime)
        return input.strftime '%y%m%d'
      elsif input.blank?
        return "      "
      else
        format_date Date.strptime(input.to_s, '%y%m%d'), length
      end
    end

    def format_nothing(_input, length)
      ' ' * length
    end

    def format_numeric(input, length)
      input = input.to_i.abs.to_s
      fail ArgumentError, "Invalid Input: #{input.inspect} (only digits are accepted) from #{self.class.to_s.demodulize}" unless input =~ /^\d+$/
      fail ArgumentError, "Not enough length (input: #{input}, length: #{length})" if input.length > length
      input.rjust(length, '0')
    end

    def format_time(input, _length)
      if input.is_a?(String) || input.is_a?(Fixnum)
        chars   = input.to_s.chars
        minutes = chars.pop(2).join.to_i
        hours   = chars.join.to_i
        input   = Time.new 0, 1, 1, hours, minutes
      end
      fail "input #{input.inspect} does not respond to #strftime!" unless input.respond_to?(:strftime)
      input.strftime '%H%M'
    end
  end
end
