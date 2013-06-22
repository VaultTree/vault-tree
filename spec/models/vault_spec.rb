require 'spec_helper'
module VaultTree
  describe 'Vault' do
    describe '#create' do

      before(:each) do
        @vault = FactoryGirl.create(:vault)
      end

      it 'is properly created' do
        @vault.should be_an_instance_of(VaultTree::Vault)
      end

    end


    describe '#lockk' do 
      before(:all) do
        @symmetric_cipher = LockSmith::SymmetricCipher.new
      end

      before(:each) do
        @key = @symmetric_cipher.generate_key
        @content = 'PLAINTEXT CONTENT'
        @vault = FactoryGirl.create(:vault, content: @content)
        @vault.lock(@key)
        @encrypted_content = @vault.content
      end

      it 'encrypted content is a non empty string' do
        @encrypted_content.should be_an_instance_of(String)
        @encrypted_content.empty?.should be false
      end

      it 'decrypted content matches Vault content' do
       dc = @symmetric_cipher.decrypt(cipher_text: @encrypted_content, key: @key)
       dc.should == @content
      end
    end

    describe '#unlock' do 
      before(:all) do
        @symmetric_cipher = LockSmith::SymmetricCipher.new
      end

      before(:each) do
        @key = @symmetric_cipher.generate_key
        @content = 'PLAINTEXT CONTENT'
        @vault = FactoryGirl.create(:vault, content: @content)
      end

      it 'the vault content is released on unlock' do
        @vault.lock(@key)
        @vault.unlock(@key)
        @vault.content.should == @content
      end

    end

  end
end
