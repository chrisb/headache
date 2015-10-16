module Headache
  module Record
    class FileHeader < Headache::Record::Base
      include Definition::FileHeader

      attr_accessor :reference_code, :creation_time, :origin, :origin_name,
                    :destination, :destination_name, :document, :creation_date,
                    :id_modifier

      def initialize(document = nil)
        @document = document
      end

      def destination
        ' ' + (@destination || '').to_s
      end

      def creation_date
        @creation_date || Date.today
      end

      def creation_time
        @creation_time || Time.now
      end

      def id_modifier
        @id_modifier || 'A'
      end

    end
  end
end
