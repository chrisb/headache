require 'spec_helper'

describe Headache::Document do
  let(:document) { build :document }

  it 'generates a document where each line is exactly 94 characters' do
    document.generate.split("\r\n").each_with_index do |line, index|
      expect(line.length).to eq(94)
    end
  end
end
