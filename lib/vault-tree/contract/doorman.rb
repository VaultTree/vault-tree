module VaultTree
  class Vault
    class Doorman
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def locked_contents
        CloseValidator.new(vault).validate!
        already_locked? ? contents : ciphertext_contents
      end

      def unlocked_contents
        OpenValidator.new(vault).validate!
        plaintext_contents
      end

      private

      def ciphertext_contents
        shared_locking_key? ? asymmetric_ciphertext : symmetric_ciphertext
      end

      def plaintext_contents
        shared_unlocking_key? ? asymmetric_plaintext : symmetric_plaintext
      end

      def asymmetric_ciphertext
        asymmetric_cipher.encrypt(public_key: locking_public_key, secret_key: locking_secret_key, plain_text: filler)
      end

      def asymmetric_plaintext
        begin
        asymmetric_cipher.decrypt(public_key: unlocking_public_key, secret_key: unlocking_secret_key, cipher_text: contents)
        rescue(RbNaCl::CryptoError)
          raise(Exceptions::FailedUnlockAttempt)
        end
      end

      def symmetric_ciphertext
        LockSmith.new(message: filler, secret_key: locking_key).symmetric_encrypt
      end

      def symmetric_plaintext
        begin
          LockSmith.new(cipher_text: contents, secret_key: unlocking_key).symmetric_decrypt
        rescue(RbNaCl::CryptoError)
          raise(Exceptions::FailedUnlockAttempt)
        end
      end

      def locking_key
        vault.locking_key
      end

      def unlocking_key
        vault.unlocking_key
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
        vault.locking_key if shared_locking_key?
      end

      def unlocking_key_pair 
        vault.unlocking_key if shared_unlocking_key?
      end

      def empty?
        vault.empty?
      end

      def already_locked?
        ! empty?
      end

      def filler
        vault.filler
      end

      def contents
        vault.contents
      end

      def shared_locking_key?
        vault.lock_with =~ /SHARED_KEY/
      end

      def shared_unlocking_key?
        vault.unlock_with =~ /SHARED_KEY/
      end

      def asymmetric_cipher
        LockSmith::AsymmetricCipher.new
      end

    end
  end
end
