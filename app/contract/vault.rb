module VaultTree
  module V3
    class Vault
      attr_reader :vault_id, :contract

      def initialize(vault_id, contract)
        @vault_id = vault_id
        @contract = contract
      end

      def close_path
        close_ancestors
        close_self_if_empty
      end

      def retrieve_contents
        open_self
      end

      def owner
        vault_description['owner']
      end

      def fill_with
        vault_description['fill_with']
      end

      def lock_type
        vault_description['lock_type']
      end

      def lock_with
        vault_description['lock_with']
      end

      def unlock_with
        vault_description['unlock_with']
      end

      def contents
        vault_description['contents']
      end

      def filler
        KeywordInterpreter.new(fill_with, self).evaluate
      end

      def locking_key
        KeywordInterpreter.new(lock_with, self).evaluate
      end

      def unlocking_key
        KeywordInterpreter.new(unlock_with, self).evaluate
      end

      private

      def vault_description
        contract.vaults[vault_id]
      end

      def close_ancestors
        close_fill_ancestor close_lock_ancestor(contract)
      end

      def close_self_if_empty
        if empty?
          contract.set_vault_contents(vault_id, close_self)
        else
          contract
        end
      end

      def open_self
        if asymmetric?
          AsymmetricVaultOpener.new(self).open
        else
          SymmetricVaultOpener.new(self).open
        end
      end

      def close_self
        if asymmetric?
          AsymmetricVaultCloser.new(self).close
        else
          SymmetricVaultCloser.new(self).close
        end
      end

      def empty?
        contents.empty?
      end

      def asymmetric?
        lock_type == 'ASYMMETRIC_MUTUAL_AUTH'
      end

      def close_lock_ancestor(c)
        lock_ancestor_vault(c).close_path
      end

      def close_fill_ancestor(c)
        fill_ancestor_vault(c).close_path
      end

      def lock_ancestor_vault(c)
        if has_lock_ancestor? 
          Vault.new(lock_ancestor_id, c) 
        else
          CommonAncestorVault.new(c)
        end
      end

      def fill_ancestor_vault(c)
        if has_fill_ancestor? 
          Vault.new(fill_ancestor_id, c) 
        else
          CommonAncestorVault.new(c)
        end
      end

      def has_lock_ancestor?
        lock_with.include? 'VAULT_CONTENTS'
      end

      def has_fill_ancestor?
        fill_with.include? 'VAULT_CONTENTS'
      end

      def lock_ancestor_id
        lock_with.gsub(/(VAULT_CONTENTS\[\')|(\'\])/,'').strip
      end

      def fill_ancestor_id
        fill_with.gsub(/(VAULT_CONTENTS\[\')|(\'\])/,'').strip
      end

    end
  end
end
