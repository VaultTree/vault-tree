require 'spec_helper'
describe 'ContractHeader' do
  describe '#as_json' do

    before :all do
      @contract_header = FactoryGirl.create(:dummy_contract_header)
      @contract_header.as_json
    end

    it 'has contract_vault key' do
      ds = ActiveSupport::JSON.decode(@contract_header.as_json)
      ds.has_key?("contract_vault_id").should == true
    end

  end
end
