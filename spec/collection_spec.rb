require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree/collection'

def sym_input
  {
    "vaults" => {
      "first" => {
        "contents"      => {"external_input" => "message"},
        "lock_key"   => {"sym_key" => {"external_input" => "first_secret_key"}},
        "unlock_key" => {"sym_key" => {"external_input" => "first_secret_key"}},
        "ciphertext"    => "",
      },

      "second" => {
        "contents"      => {"vault_contents" => "first"},
        "lock_key"   => {"sym_key" => {"external_input" => "second_secret_key"}},
        "unlock_key" => {"sym_key" => {"external_input" => "second_secret_key"}},
        "ciphertext" => "",
      }
    },
    "external_input" => {
      "message"  => "Hello World",
      "first_secret_key"  => "ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605",
      "second_secret_key" => "03def0140f339de41e1ee6223b68dd6e0c88273ce33d6d9a7e0989bac38df947"
    }
  }
end


def single_vault
  {
    "vaults" => {
      "first" => {
        "contents"      => {"random_key" => "sym_key"},
        "lock_key"   => {"sym_key" => {"random_key" => "sym_key"}},
        "unlock_key" => {"sym_key" => {"random_key" => "sym_key"}},
        "ciphertext"    => "",
      }
    },
    "external_input" => {}
  }
end

module VaultTree
  describe Collection do
    describe '#close_vault' do
      it 'close algorithm with symmetric keys' do
        c = Collection.new.close_vault('first', single_vault)
        c['vaults']['first']['ciphertext'].empty?.must_equal(false)
      end
    end

    describe '#close_vault | #open_vault' do
      it 'open | close algorithm with symmetric keys' do
        c = Collection.new.close_vault('second', sym_input)
        r = Collection.new.open_vault('second', c)
        r.must_equal("Hello World")
      end

      it 'open | close algorithm with asymmetric keys' do
        c = Collection.new.close_vault('second', sym_input)
        r = Collection.new.open_vault('second', c)
        r.must_equal("Hello World")
      end
    end
  end
end
