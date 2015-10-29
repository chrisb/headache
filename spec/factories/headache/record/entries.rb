FactoryGirl.define do
  factory :entry, class: Headache::Record::Entry do |f|
    skip_create

    f.routing_number '555555555'
    f.account_number '5555555555'
    f.amount 10000 # $100
    f.internal_id 'ABC123'
    f.trace_number 'DEF456'
    f.individual_name 'Bob Smith'
    f.transaction_code 'abc123def456'
  end

  factory :another_entry, parent: :entry do |f|
    f.routing_number '111111119'
  end


end
