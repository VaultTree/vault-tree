require 'spec_helper'

module VaultTree
  module Templates
    describe 'TemplateSpike' do

      it 'reads in the erb' do 
        pending
        filename = VaultTree::PathHelpers.one_two_three_030
        r = Support::JSON.decode(File.read(filename))
        puts 'DECODED ERB FILE'
        puts r
      end

      it 'executes the erb' do 
        pending
        alice = User.new(user_id: 'alice')
        bob = User.new(user_id: 'bob')
        filename = VaultTree::PathHelpers.one_two_three_030
        result = ERB.new(File.read(filename)).result(binding)
        puts 'FIRST EVALUATED ERB RESULT'
        puts result 
        raise 'You left of here. Need to pass the active contract'
        puts 'SECOND EVALUATED ERB RESULT'
        result = ERB.new(File.read(filename)).result(binding)
        puts result 
      end
    end
  end
end

module Contract
  def contract
    VaultTree::Support::JSON.decode(File.read(contract_filename))
  end

  def contract_filename
    VaultTree::PathHelpers.one_two_three_030
  end
end

class Vault
  include Contract
  attr_reader :vault_id, :user

  def initialize(opts)
    @vault_id = opts[:vault_id]
    @user = opts[:user]
  end

  def ciphertext
    'ciphertext'
  end

  def plaintext
    'plaintext'
  end
end

class PublicData
  include Contract
  attr_reader :user, :party_id

  def initialize(opts)
    @party_id = opts[:party_id]
    @user = opts[:user]
  end

  def address
    begin
      @user.address
    rescue
      contract_public_data['address']
    end
  end

  def verification_key
    begin
      @user.verification_key
    rescue
      contract_public_data['verification_key']
    end
  end

  def contract_consent_key 
    begin
      @user.contract_consent_key 
    rescue
      contract_public_data['contract_consent_key']
    end
  end

  def public_encryption_key
    begin
      @user.public_encryption_key
    rescue
      contract_public_data['public_encryption_key']
    end
  end

  private

  def contract_public_data
    contract['parties'][party_id]['public_data']
  end
end


class PrivateData
  include Contract
  attr_reader :user, :party_id

  def initialize(opts)
    @party_id = opts[:party_id]
    @user = opts[:user]
  end

  def decryption_key 
    begin
      encrypt_with_master(user.decryption_key)
    rescue
      contract_private_data['decryption_key']
    end
  end

  def signing_key
    begin
      encrypt_with_master(user.signing_key)
    rescue
      contract_private_data['signing_key']
    end
  end

  private

  def master_passphrase
    user.master_passphrase
  end

  def encrypt_with_master(plain_text)
    symmetric_cipher.encrypt(plain_text: plain_text, key: master_passphrase)
  end

  def symmetric_cipher
    VaultTree::LockSmith::SymmetricCipher.new
  end

  def contract_private_data
    contract['parties'][party_id]['private_data']
  end
end

class PublicSignature
  include Contract
  attr_reader :user, :party_id

  def initialize(opts)
    @party_id = opts[:party_id]
    @user = opts[:user]
  end

  def address
    begin
      generate_signature(contract_public_data['address'], signing_key)
    rescue
      contract_public_signatures['address']['signature']
    end
  end

  private

  def signing_key
    decrypt_with_master encrypted_signing_key
  end

  def encrypted_signing_key
    contract_private_data['signing_key']
  end

  def master_passphrase
    user.master_passphrase
  end

  def decrypt_with_master(cipher_text)
    symmetric_cipher.decrypt(cipher_text: cipher_text, key: master_passphrase)
  end

  def generate_signature(msg, sk)
    LockSmith::DigitalSignature.new(message: msg, signing_key: sk).generate
  end

  def symmetric_cipher
    VaultTree::LockSmith::SymmetricCipher.new
  end

  def contract_private_data
    contract['parties'][party_id]['private_data']
  end

  def contract_public_data
    contract['parties'][party_id]['public_data']
  end

  def contract_public_signatures
    contract['parties'][party_id]['public_signatures']
  end
end
