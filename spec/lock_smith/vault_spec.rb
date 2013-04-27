require 'spec_helper'

module LockSmith
  describe 'Vault' do
    before :all do
      #@locked_vault = Fixtures.locked_vault
      #@unlocked_vault = Fixtures.unlocked_vault
    end

    describe '#vault_rack' do
      it 'returns the correct vault rack object' do
        pending
        vr = Vault.new(@json).vault_rack
        vr.as_json.should == Fixtures.vault_rack
      end
    end

    describe '#as_json' do
      it 'returns the correct string' do
        pending
      end

      it 'returns an empty vault string when no argument is given' do
        pending
      end
    end
  end
end
