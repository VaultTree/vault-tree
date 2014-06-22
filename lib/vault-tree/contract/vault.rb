module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      begin
        @properties['contents'] = lock_contents
        self
      rescue RbNaCl::CryptoError => e
        raise Exceptions::FailedLockAttempt.new(e, vault_id: id)
      end
    end

    def open
      begin
        contract.close_vault(id)
        unlock_contents
      rescue RbNaCl::CryptoError => e
        raise Exceptions::FailedUnlockAttempt.new(e, vault_id: id)
      end
    end

    def filler
      KeywordInterpreter.new(properties['fill_with'], self).evaluate
    end

    def locking_key
      KeywordInterpreter.new(properties['lock_with'], self).evaluate
    end

    def unlocking_key
      KeywordInterpreter.new(properties['unlock_with'], self).evaluate
    end

    def lock_contents
      already_locked? ? properties['contents'] : encrypt_contents
    end

    def unlock_contents
      plaintext_contents
    end

    def encrypt_contents
      dh_locking_key? ? asymmetric_ciphertext : symmetric_ciphertext
    end

    def plaintext_contents
      dh_unlocking_key? ? asymmetric_plaintext : symmetric_plaintext
    end

    def asymmetric_ciphertext
      LockSmith.new(public_key: locking_public_key, private_key: locking_secret_key, message: filler).asymmetric_encrypt
    end

    def asymmetric_plaintext
      LockSmith.new(public_key: unlocking_public_key, private_key: unlocking_secret_key, cipher_text: properties['contents'] ).asymmetric_decrypt
    end

    def symmetric_ciphertext
      LockSmith.new(message: filler, secret_key: locking_key).symmetric_encrypt
    end

    def symmetric_plaintext
      LockSmith.new(cipher_text: properties['contents'], secret_key: unlocking_key).symmetric_decrypt
    end

    def locking_public_key
      locking_key_pair.public_key
    end

    def locking_secret_key
      locking_key_pair.secret_key
    end

    def unlocking_public_key
      unlocking_key_pair.public_key
    end

    def unlocking_secret_key
      unlocking_key_pair.secret_key
    end

    def locking_key_pair
      locking_key if dh_locking_key?
    end

    def unlocking_key_pair
      unlocking_key if dh_unlocking_key?
    end

    def empty_contents?
      properties['contents'].nil? || properties['contents'].empty?
    end

    def already_locked?
      ! empty_contents?
    end

    def dh_locking_key?
      properties['lock_with'] =~ /DH_KEY/
    end

    def dh_unlocking_key?
      properties['unlock_with'] =~ /DH_KEY/
    end
  end
end
