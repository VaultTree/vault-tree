module VaultTree
  module V3
    class Vault
      attr_reader :vault_id

      def initialize(vault_id)
        @vault_id = vault_id
      end

      def close_all_ancestors(c) #consider contract as instance var?
        c = close_all_lock_ancestors(c)
        c = close_all_fill_ancestors(c)
        close_self(c)
      end

      def retrieve_contents(c)
        opened_contents(c)
      end

      private

      def opened_contents(c)
        key = discover_unlocking_key(c)
        cipher_text = discover_contents(c)
        decrypt(key,cipher_text)
      end

      def close_self(c)
        c.set_vault_contents(vault_id, closed_contents(c))
      end

      def closed_contents(c)
        key = discover_locking_key(c)
        fill = discover_vault_fill(c)
        encrypt(key,fill)
      end

      def discover_unlocking_key(c)
        ulw = unlock_with(c)
        Keyword.new(ulw,c).evaluate
      end

      def discover_contents(c)
        contents(c)
      end

      def discover_locking_key(c)
        lw = lock_with(c)
        Keyword.new(lw,c).evaluate
      end

      def discover_vault_fill(c)
        fw = fill_with(c)
        Keyword.new(fw,c).evaluate
      end

      def close_all_lock_ancestors(c)
        lock_ancestor_vault(c).close_all_ancestors(c)
      end

      def close_all_fill_ancestors(c)
        fill_ancestor_vault(c).close_all_ancestors(c)
      end

      def lock_ancestor_vault(c)
        infer_lock_ancestor(c) || CommonAncestorVault.new
      end

      def fill_ancestor_vault(c)
        infer_fill_ancestor(c) || CommonAncestorVault.new
      end

      def fill_with(c)
        vault_hash(c)['fill_with']
      end

      def lock_with(c)
        vault_hash(c)['lock_with']
      end

      def unlock_with(c)
        vault_hash(c)['unlock_with']
      end

      def contents(c)
        vault_hash(c)['contents']
      end

      def vault_hash(c)
        c.vaults[vault_id]
      end

      def infer_lock_ancestor(c)
        s = lock_with(c)
        has_ancestor?(s) && Vault.new( extract_ancestor_id(s) )
      end

      def infer_fill_ancestor(c)
        s = fill_with(c)
        has_ancestor?(s) && Vault.new( extract_ancestor_id(s) )
      end

      def has_ancestor?(s)
        s.include? 'VAULT_CONTENTS'
      end

      def extract_ancestor_id(s)
        s.gsub(/(VAULT_CONTENTS\[\')|(\'\])/,'').strip
      end

      def symmetric_cipher
        LockSmith::SymmetricCipher.new
      end

      def encrypt(key,plain_text)
        symmetric_cipher.encrypt(key: key, plain_text: plain_text)
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
      def close_all_ancestors(contract)
        contract
      end
    end
  end
end
