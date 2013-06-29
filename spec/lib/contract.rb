require 'spec_helper'

module VaultTree
  module Support
    describe 'Contract' do
      before :all do
        @json = File.open(VaultTree::PathHelpers.one_two_three_020).read
        @CONTRACT = Contract.new(@json) 
      end

      it 'pends' do
        pending
      end
    end
  end
end
