require 'spec_helper'

describe 'Contract' do
  describe '#create' do

    before(:each) do
      @contract = FactoryGirl.create(:dummy_contract)
    end

    it 'has_many nodes' do
      @contract.nodes.length.should be > 1
    end

    it 'can access its nodes' do
      @contract.nodes.first.should be_an_instance_of(VaultTree::Node)
    end

    it 'each node is different' do
      f = @contract.nodes.first.content
      l = @contract.nodes.last.content
      f.should_not == l
    end

    it 'has_one contract_header' do
      @contract.contract_header.should be_an_instance_of(VaultTree::ContractHeader)
    end
  end
end
