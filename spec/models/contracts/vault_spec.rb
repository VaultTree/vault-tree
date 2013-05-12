require 'spec_helper'
describe 'Vault' do
  describe '#as_json' do

    before :all do
      @vault = FactoryGirl.create(:dummy_vault)
    end

    it 'has an id key' do
      ds = ActiveSupport::JSON.decode(@vault.as_json)
      ds.has_key?("id").should == true
    end

    it 'has a content key' do
      ds = ActiveSupport::JSON.decode(@vault.as_json)
      ds.has_key?("content").should == true
    end
  end
end
