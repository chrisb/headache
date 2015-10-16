module Headache
  module Record
    class BatchHeader < Headache::Record::Base
      include Definition::BatchHeader

      attr_accessor :batch, :document

      delegate :batch_number, :'batch_number=', :service_code, :odfi_id, :'odfi_id=',
               :company_identification, :'company_identification=', :company_name,
               :'company_name=', :entry_description, :'entry_description=', :discretionary,
               :'discretionary=', :entry_class_code, :'entry_class_code=', :effective_date,
               :'effective_date=', :'type=', :descriptive_date,
               :'descriptive_date=', to: :batch

      def initialize(batch = nil, document = nil)
        @batch    = batch
        @document = document
      end

      def parse_fields(record_string)
        fields = super
        type   = Headache::Batch.type_from_service_code(fields.delete :service_code)
        fields.merge(type: type)
      end
    end
  end
end
