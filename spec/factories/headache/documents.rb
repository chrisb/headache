FactoryGirl.define do
  factory :document, class: Headache::Document do |f|
    skip_create

    after(:build) do |document, evaluator|
      10.times do
        batch = build(:batch)
        batch.document = document
        document.add_batch(batch)
      end
    end
  end
end
