require_relative 'expression.rb'
require_relative 'vault.rb'

module VaultTree
  class Collection

    def close_vault(id, collection)
      new_collection = collection.clone
      assert_vault_present! new_collection, id
      new_collection['vaults'][id] = _closed_vault(new_collection, id)
      new_collection
    end

    def open_vault(id, collection)
      new_collection = collection.clone
      assert_vault_present! new_collection, id
      new_closed_collection = self.close_vault(id, new_collection)
      _opened_contents(new_closed_collection, id)
    end

    protected

    def assert_vault_present!(c, id)
      raise VaultMissingError if vault_missing?(id, c)
    end

    def _closed_vault(c, id)
      new_c = c.clone
      new_c['vaults'][id]['ciphertext'] = ciphertext_on_closing(c, id)
      new_c['vaults'][id]
    end

    def _opened_contents(c, id)
      new_c = c.clone
      compute_plaintext(new_c , id)
    end

    def vault_missing?(id, collection)
      collection['vaults'][id].nil?
    end

    def ciphertext_on_closing(c, id)
      vault_open?(id, c) ? compute_ciphertext(c, id) : existing_ciphertext(c,id)
    end

    def vault_open?(id, collection)
      collection['vaults'][id]['ciphertext'].empty?
    end

    def compute_ciphertext(c, id)
      VaultTree::Vault.new.close plaintext_contents(c,id), existing_ciphertext(c,id), plaintext_locking_key(c,id)
    end

    def compute_plaintext(c, id)
      VaultTree::Vault.new.open existing_ciphertext(c,id), plaintext_unlocking_key(c,id)
    end

    def existing_ciphertext(c,id)
      c['vaults'][id]['ciphertext']
    end

    def plaintext_locking_key(c,id)
      {
        "sym_key"      => evaluate_expression(c, c['vaults'][id]['lock_key']['sym_key']     , id),
        "asym_prv_key" => evaluate_expression(c, c['vaults'][id]['lock_key']['asym_prv_key'], id),
        "asym_pub_key" => evaluate_expression(c, c['vaults'][id]['lock_key']['asym_pub_key'], id),
      }
    end

    def plaintext_unlocking_key(c,id)
      {
        "sym_key"      => evaluate_expression(c, c['vaults'][id]['unlock_key']['sym_key']     , id),
        "asym_prv_key" => evaluate_expression(c, c['vaults'][id]['unlock_key']['asym_prv_key'], id),
        "asym_pub_key" => evaluate_expression(c, c['vaults'][id]['unlock_key']['asym_pub_key'], id),
      }
    end

    def plaintext_contents(c,id)
      evaluate_expression(c, c['vaults'][id]['contents'], id)
    end

    def evaluate_expression(c, e, vault_id)
      Expression.new(e).expression_object.evaluate(c, vault_id)
    end
  end
end

class VaultMissingError < StandardError
end
