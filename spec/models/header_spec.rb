require 'spec_helper'

describe 'Header' do
  describe '#create' do

    before(:each) do
      @header = FactoryGirl.create(:header)
    end

    it 'is properly created' do
      @header.should be_an_instance_of(VaultTree::Header)
    end
  end
end
