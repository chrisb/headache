module Headache
  module Definition
    module FileControl
      extend ActiveSupport::Concern

      included do
        include Common

        field :batch_count,   6,   '2-7', :numeric_value
        field :block_count,   6,  '8-13', :numeric_value
        field :entry_count,   8, '14-21', :numeric_value
        field :entry_hash,   10, '22-31', :numeric
        field :total_debit,  12, '32-43', :numeric_value
        field :total_credit, 12, '44-55', :numeric_value
        field :reserved,     39, '56-94', :nothing

        field_value :reserved, ''
      end
    end
  end
end
