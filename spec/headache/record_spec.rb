require 'spec_helper'

describe Headache::Record do
  let(:file_header) { Headache::Record::FileHeader.new }
  let(:line) { file_header.generate.gsub "\r\n", '' }


  it 'should use the subclassed field value' do
    file_header.origin_name = 'THIS ROCKS'
    expect(line).to include('THIS ROCKS')
  end
end
