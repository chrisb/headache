require 'spec_helper'

describe Headache::Batch do
  subject { described_class.new }

  it 'should correctly compute the entry_hash value from the routing identification number' do
    subject << create(:entry)
    expect { subject << create(:another_entry) }
      .to change { subject.entry_hash }
      .from(55555555)
      .to(66666666)
  end

end
