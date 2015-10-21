module Headache
  module Record
    class FileControl < Headache::Record::Base
      include Definition::FileControl

      attr_accessor :document

      def initialize(document = nil)
        @document = document
      end

      def batch_count
        document.batches.count
      end

      def block_count
        (((batch_count * 2) + document.entries.count + 2) / 10.0).ceil
      end

      def entry_count
        document.entries.count
      end

      def entry_hash
        batch_sum(:entry_hash).to_s.last(10)
      end

      def total_debit
        batch_sum :total_debit
      end

      def total_credit
        batch_sum :total_credit
      end

      protected

      def batch_sum(method)
        document.batches
          .map { |b| b.send method }
          .map(&:to_i).sum
      end

    end
  end
end
