require 'spec_helper'

module LockSmith
  describe 'SymmetricVault' do
    before :all do
      @json = Fixtures.symmetric_vault
    end

    describe '#vault_rack' do
      it 'returns the correct vault rack object' do
        vr = SymmetricVault.new(@json).vault_rack
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

    describe '#type' do
      it 'returns symmetric vault' do
        pending
      end
    end

    describe '#lock' do
    end

    describe '#unlock' do
    end

  end
end
