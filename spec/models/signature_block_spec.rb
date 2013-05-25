require 'spec_helper'

module VaultTree
  describe 'SignatureBlock' do
    describe '#create' do

      before(:each) do
        @signature_block = FactoryGirl.create(:signature_block)
      end

      it 'is properly created' do
        @signature_block.should be_an_instance_of(SignatureBlock)
      end

    end
  end
end
