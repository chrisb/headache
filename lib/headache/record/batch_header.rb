module Headache
  module Record
    class BatchHeader < Fixy::Record
      include Definition::BatchHeader

      attr_accessor :batch, :document

      delegate :batch_number, :'batch_number=', :service_code, :odfi_id, :'odfi_id=',
               :company_identification, :'company_identification=', :company_name,
               :'company_name=', :entry_description, :'entry_description=', :discretionary,
               :'discretionary=', :entry_class_code, :'entry_class_code=', :effective_date,
               :'effective_date=', to: :batch

      def initialize(batch = nil, document = nil)
        @batch    = batch
        @document = document
      end
    end
  end
end
