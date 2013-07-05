require 'spec_helper'

module VaultTree
  module Support
    describe 'Contract' do
      before :all do
        pending
        @json = File.open(VaultTree::PathHelpers.one_two_three_020).read
        @CONTRACT = Contract.new(@json)
      end

      describe '[]' do
        it 'basic access' do
          pending
          @CONTRACT["participants"].should be_an_instance_of(Hash)
        end

        it 'complex access' do
          pending
          @CONTRACT["participants"][@CONTRACT["vaults"]["FIRST"]["custodian"]]["address"].should == "bob@bob.com"
        end
      end
    end
  end
end