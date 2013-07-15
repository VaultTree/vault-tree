require 'spec_helper'

module VaultTree
  describe 'DigitalSignature' do
    describe '#verify' do

      it 'returns true for valid signatures' do
        verify_key = 'w/pMtC2eyjYwv+xtbArdcFosYNsoUMTPjacuUgjZ7mU='
        signature = 'D1xfXgWxFwaRLsNPiLl9gd96K1WnR/Tsv8NjgeFTiF4TmEtSogdF2yrH1FH0WMu5Adaa5YKU0uyKj+jge2YpBw=='
        attribute_value = 'bob@auto_bot.com'
        @digital_signature = LockSmith::DigitalSignature.new(message: attribute_value, verify_key: verify_key, signature: signature)
        @digital_signature.verify.should be true
      end

      it 'returns true for valid signatures' do
        pending 'Not Implemented'
      end
    end
  end
end
