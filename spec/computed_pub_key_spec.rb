require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree/collection'

def input
  {
    "vaults" => {
      "locking_secret_key" => {
        "contents"   => {"random_key" => "asym_prv_key"},
        "lock_key"   => {"sym_key" => {"open_key" => "sym_key"}},
        "unlock_key" => {"sym_key" => {"open_key" => "sym_key"}},
        "ciphertext"    => "",
      },

      "locking_public_key" => {
        "contents"   => {"computed_pub_key" => {"vault_contents" => "locking_secret_key"}},
        "lock_key"   => {"sym_key" => {"open_key" => "sym_key"}},
        "unlock_key" => {"sym_key" => {"open_key" => "sym_key"}},
        "ciphertext" => "",
      },

      "unlocking_secret_key" => {
        "contents"   => {"random_key" => "asym_prv_key"},
        "lock_key"   => {"sym_key" => {"open_key" => "sym_key"}},
        "unlock_key" => {"sym_key" => {"open_key" => "sym_key"}},
        "ciphertext"    => "",
      },

      "unlocking_public_key" => {
        "contents"   => {"computed_pub_key" => {"vault_contents" => "unlocking_secret_key"}},
        "lock_key"   => {"sym_key" => {"open_key" => "sym_key"}},
        "unlock_key" => {"sym_key" => {"open_key" => "sym_key"}},
        "ciphertext" => "",
      },

      "secret_message" => {
        "contents"   => {"external_input" => "msg"},
        "lock_key"   => {
          "asym_prv_key" => {"vault_contents" => "locking_secret_key"},
          "asym_pub_key" => {"vault_contents" => "unlocking_public_key"}
         },
        "unlock_key" => {
           "asym_prv_key" => {"vault_contents" => "unlocking_secret_key"},
           "asym_pub_key" => {"vault_contents" => "locking_public_key"}
         },
        "ciphertext" => "",
      }
    },
    "external_input" => {
      "msg"  => "Hello Secret Message!"
    }
  }
end

module VaultTree
  describe 'computed_pub_key expression' do
    it 'lock order: locking_secret_key, locking_public_key, secret_message' do
      @collection = Collection.new.close_vault('locking_secret_key', input)
      @collection = Collection.new.close_vault('locking_public_key', @collection)
      @collection = Collection.new.close_vault('secret_message', @collection)
      @collection['vaults']['secret_message']['ciphertext'].empty?.must_equal false
    end

    it 'lock order: locking_public_key, secret_message' do
      @collection = Collection.new.close_vault('locking_public_key', input)
      @collection = Collection.new.close_vault('secret_message', @collection)
      @collection['vaults']['secret_message']['ciphertext'].empty?.must_equal false
    end

    it 'lock order: secret_message' do
      @collection = Collection.new.close_vault('secret_message', input)
      @collection['vaults']['secret_message']['ciphertext'].empty?.must_equal false
    end
  end

  describe '#close_vault | #open_vault' do
    it 'open | close algorithm with asymmetric encryption' do
      @collection = Collection.new.close_vault('secret_message', input)
      @collection = Collection.new.close_vault('locking_public_key', @collection)
      @collection['vaults']['locking_public_key']['ciphertext'].empty?.must_equal false
      @collection['vaults']['locking_secret_key']['ciphertext'].empty?.must_equal false
      @collection['vaults']['unlocking_public_key']['ciphertext'].empty?.must_equal false
      @collection['vaults']['unlocking_secret_key']['ciphertext'].empty?.must_equal false
      @collection['vaults']['secret_message']['ciphertext'].empty?.must_equal false
      msg = Collection.new.open_vault('secret_message', @collection)
      msg.must_equal 'Hello Secret Message!'
    end
  end
end
