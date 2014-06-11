module VaultTree
  class Vault
    class Doorman
      attr_reader :vault, :properties

      def initialize(params = {})
        @vault = params[:vault]
        @properties = params[:properties]
      end

      def lock_contents
        already_locked? ? contents : ciphertext_contents
      end

      def unlock_contents
        raise Exceptions::EmptyVault if empty_contents?
        plaintext_contents
      end

      def ciphertext_contents
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
        vault.lock_with =~ /DH_KEY/
      end

      def dh_unlocking_key?
        vault.unlock_with =~ /DH_KEY/
      end

      def fill_ancestor
        fill_with.extract_ancestor_id if has_fill_ancestor?
      end

      def lock_ancestor
        lock_with.extract_ancestor_id if has_lock_ancestor?
      end

      def has_lock_ancestor?
        lock_with_key_or_contents?
      end

      def lock_with_key_or_contents?
        (locking_word_base == 'CONTENTS') || (locking_word_base == 'KEY')
      end

      def has_fill_ancestor?
        fill_with_key_or_contents?
      end

      def fill_with_key_or_contents?
        (filling_word_base == 'CONTENTS') || (filling_word_base == 'KEY')
      end

      def filling_word_base
        word_base fill_with
      end

      def locking_word_base
        word_base lock_with
      end

      def word_base(word)
        word.gsub(/(\[.*\])/,'').strip
      end
    end
  end
end
