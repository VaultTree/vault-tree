module VaultTree
  module V3
    class Vault
      attr_reader :vault_id, :contract

      def initialize(vault_id, contract)
        @vault_id = vault_id
        @contract = contract
      end

      def close_all_ancestors
        c = close_all_lock_ancestors(contract)
        c = close_all_fill_ancestors(c)
        close_self
      end

      def retrieve_contents
        opened_contents
      end

      private

      def opened_contents
        if asymmetric_mutual_auth?
          open_asymmetric
        else
          open_symmetric
        end
      end

      def closed_contents
        if asymmetric_mutual_auth?
          close_asymmetric
        else
          close_symmetric
        end
      end

      def closed?
        ! empty?
      end

      def empty?
        contents.empty?
      end

      def asymmetric_mutual_auth?
        lock_type == 'ASYMMETRIC_MUTUAL_AUTH'
      end

      def open_asymmetric
        cipher_text = discover_contents
        key = Keyword.new("VAULT_CONTENTS['alice_decryption_key']", contract).evaluate
        pub_key = Keyword.new("VAULT_CONTENTS['bob_public_encryption_key']", contract).evaluate
        asymmetric_decrypt(pub_key,key,cipher_text)
      end

      def open_symmetric
        key = discover_unlocking_key
        cipher_text = discover_contents
        decrypt(key,cipher_text)
      end

      def close_symmetric
        key = discover_locking_key
        fill = discover_vault_fill
        encrypt(key,fill)
      end

      def close_asymmetric
        key = discover_locking_key
        fill = discover_vault_fill
        priv_key = discover_bob_decryption_key
        asymmetric_encrypt(key, priv_key, fill)
      end

      def close_self
        if empty?
          contract.set_vault_contents(vault_id, closed_contents)
        else
          contract
        end
      end

      def discover_bob_public_key
        stg = "VAULT_CONTENTS['bob_public_encryption_key']"
        Keyword.new(stg,contract).evaluate # THIS VALUE IS GOOD!
      end

      def discover_bob_decryption_key
        stg = "VAULT_CONTENTS['bob_decryption_key']"
        Keyword.new(stg,contract).evaluate # THIS VALUE IS GOOD!
      end

      def discover_alice_decryption_key
        stg = "VAULT_CONTENTS['alice_decryption_key']"
        Keyword.new(stg,contract).evaluate # THIS VALUE IS GOOD!
      end

      def discover_unlocking_key
        ulw = unlock_with
        Keyword.new(ulw,contract).evaluate
      end

      def discover_contents
        contents
      end

      def discover_locking_key
        lw = lock_with
        Keyword.new(lw,contract).evaluate
      end

      def discover_vault_fill
        fw = fill_with
        Keyword.new(fw,contract).evaluate
      end

      def close_all_lock_ancestors(c)
        lock_ancestor_vault(c).close_all_ancestors
      end

      def close_all_fill_ancestors(c)
        fill_ancestor_vault(c).close_all_ancestors
      end

      def lock_ancestor_vault(c)
        infer_lock_ancestor(c) || CommonAncestorVault.new(c)
      end

      def fill_ancestor_vault(c)
        infer_fill_ancestor(c) || CommonAncestorVault.new(c)
      end

      def fill_with
        vault_hash['fill_with']
      end

      def owner
        vault_hash['owner']
      end

      def lock_type
        h = vault_hash
        h['lock_type'] if h.has_key?('lock_type')
      end

      def lock_with
        vault_hash['lock_with']
      end

      def unlock_with
        vault_hash['unlock_with']
      end

      def contents
        vault_hash['contents']
      end

      def vault_hash
        contract.vaults[vault_id]
      end

      def infer_lock_ancestor(c)
        has_lock_ancestor? && Vault.new( extract_ancestor_id(lock_with), c)
      end

      def infer_fill_ancestor(c)
        has_fill_ancestor? && Vault.new( extract_ancestor_id(fill_with), c)
      end

      def has_lock_ancestor?
        lock_with.include? 'VAULT_CONTENTS'
      end

      def has_fill_ancestor?
        fill_with.include? 'VAULT_CONTENTS'
      end

      def extract_ancestor_id(s)
        s.gsub(/(VAULT_CONTENTS\[\')|(\'\])/,'').strip
      end

      def symmetric_cipher
        LockSmith::SymmetricCipher.new
      end

      def asymmetric_cipher
        LockSmith::AsymmetricCipher.new
      end

      def encrypt(key,plain_text)
        symmetric_cipher.encrypt(key: key, plain_text: plain_text)
      end

      def asymmetric_encrypt(pub_key,priv_key,fill)
        asymmetric_cipher.encrypt(pub_key,priv_key,fill)
      end

      def asymmetric_decrypt(pub_key,priv_key,cipher_text)
        asymmetric_cipher.decrypt(pub_key,priv_key,cipher_text)
      end

      def decrypt(key,cipher_text)
        symmetric_cipher.decrypt(key: key, cipher_text: cipher_text)
      end


    end
  end
end

module VaultTree
  module V3
    class CommonAncestorVault
      attr_reader :contract

      def initialize(contract)
        @contract = contract
      end

      def close_all_ancestors
        contract
      end
    end
  end
end
