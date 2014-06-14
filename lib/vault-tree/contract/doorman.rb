module VaultTree
  class Vault
    class Doorman
      attr_reader :vault, :properties

      def initialize(params = {})
        @vault = params[:vault]
        @properties = params[:properties]
      end

      def lock_contents
        begin
          already_locked? ? contents : encrypt_contents
        rescue RbNaCl::CryptoError => e
          raise Exceptions::FailedLockAttempt.new(e, vault_id: vault.id)
        end
      end

      def unlock_contents
        begin
          plaintext_contents
        rescue RbNaCl::CryptoError => e
          raise Exceptions::FailedUnlockAttempt.new(e, vault_id: vault.id)
        end
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
        LockSmith.new(public_key: unlocking_public_key, private_key: unlocking_secret_key, cipher_text: contents).asymmetric_decrypt
      end

      def symmetric_ciphertext
        LockSmith.new(message: filler, secret_key: locking_key).symmetric_encrypt
      end

      def symmetric_plaintext
        LockSmith.new(cipher_text: contents, secret_key: unlocking_key).symmetric_decrypt
      end

      def fill_with
        properties['fill_with']
      end

      def lock_with
        properties['lock_with']
      end

      def unlock_with
        properties['unlock_with']
      end

      def contents
        properties['contents']
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
        vault.locking_key if dh_locking_key?
      end

      def unlocking_key_pair
        vault.unlocking_key if dh_unlocking_key?
      end

      def empty_contents?
        contents.nil? || contents.empty?
      end

      def already_locked?
        ! empty_contents?
      end

      def filler
        vault.filler
      end

      def dh_locking_key?
        lock_with =~ /DH_KEY/
      end

      def dh_unlocking_key?
        unlock_with =~ /DH_KEY/
      end
    end
  end
end
