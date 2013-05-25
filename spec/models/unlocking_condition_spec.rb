require 'spec_helper'
describe 'UnlockingCondition' do

  describe '#create' do
    before(:each) do
      @unlocking_condition = FactoryGirl.create(:unlocking_condition)
    end

    it 'has_one unlocking certificate' do
      @unlocking_condition.unlocking_certificate.should be_an_instance_of(VaultTree::UnlockingCertificate)
    end
  end
end
