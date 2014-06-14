module VaultTree
  class Vault
    class Doorman
      attr_reader :vault

      def initialize(params = {})
        @vault = params[:vault]
      end

      def lock_contents
        already_locked? ? vault.contents : encrypt_contents
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
        LockSmith.new(public_key: unlocking_public_key, private_key: unlocking_secret_key, cipher_text: vault.contents).asymmetric_decrypt
      end

      def symmetric_ciphertext
        LockSmith.new(message: filler, secret_key: locking_key).symmetric_encrypt
      end

      def symmetric_plaintext
        LockSmith.new(cipher_text: vault.contents, secret_key: unlocking_key).symmetric_decrypt
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
        vault.contents.nil? || vault.contents.empty?
      end

      def already_locked?
        ! empty_contents?
      end

      def filler
        vault.filler
      end

      def dh_locking_key?
        vault.lock_with =~ /DH_KEY/
      end

      def dh_unlocking_key?
        vault.unlock_with =~ /DH_KEY/
      end
    end
  end
end
