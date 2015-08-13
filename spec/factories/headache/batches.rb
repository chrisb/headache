FactoryGirl.define do
  factory :batch, class: Headache::Batch do |f|
    skip_create

    type :debit
    sequence :batch_number

    after(:build) do |batch, evaluator|
      10.times do
        entry = build(:entry)
        entry.batch = batch
        entry.document = batch.document
        batch.add_entry(entry)
      end
    end
  end
end
