module Headache
  module Formatters
    include Fixy::Formatter::Alphanumeric

    def format_alphanumeric(input, length)
      super(input, length).upcase
    end

    def format_date(input, _length)
      fail "input #{input.inspect} does not respond to #strftime!" unless input.respond_to?(:strftime)
      input.strftime '%y%m%d'
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
      fail "input #{input.inspect} does not respond to #strftime!" unless input.respond_to?(:strftime)
      input.strftime '%H%M'
    end
  end
end
