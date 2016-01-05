require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree/collection_builder'

def vaults
  {
    "first" => {
      "contents"      => {"random_key" => "sym_key"},
      "locking_key"   => {"sym_key" => {"open_key" => "sym_key"}},
      "unlocking_key" => {"sym_key" => {"open_key" => "sym_key"}},
      "ciphertext"    => "",
    },

    "second" => {
      "contents"      => {"random_key" => "sym_key"},
      "locking_key"   => {"sym_key" => {"vault_contents" => "first"}},
      "unlocking_key" => {"sym_key" => {"vault_contents" => "first"}},
      "ciphertext" => "",
    }
  }
end

def external_input
  {"first_input" => "first_secret_value", "second_input" => "second_secret_value"}
end

def sym_external_input
  {first_input: "first_secret_value", second_input: "second_secret_value"}
end

module VaultTree
  describe CollectionBuilder do
    describe '#combined_collection' do
      it 'returns the combined collection hash' do
        CollectionBuilder.new.combined_collection(vaults, external_input).is_a?(Hash).must_equal true
      end

      it 'you can access the vaults' do
        r = CollectionBuilder.new.combined_collection(vaults, external_input)
        r['vaults']['first']['contents'].must_equal({"random_key" => "sym_key"})
      end

      it 'you can access the external data' do
        r = CollectionBuilder.new.combined_collection(vaults, external_input)
        r['external_input']['first_input'].must_equal("first_secret_value")
      end

      it 'external data is converted to a hash with string keys' do
        r = CollectionBuilder.new.combined_collection(vaults, sym_external_input)
        r['external_input'].keys.first.is_a?(String).must_equal(true)
      end

      it 'nil values are returned when no external data is give' do
        r = CollectionBuilder.new.combined_collection(vaults, nil)
        r['external_input']['first_input'].must_equal(nil)
      end
    end

    describe '#stringify_keys' do
      it 'returns a hash of string keys if the given keys are symbols' do
        h = {key_one: "val_one", key_two: "val_two"}
        CollectionBuilder.new.stringify_keys(h).must_equal({"key_one" => "val_one", "key_two" => "val_two"})
      end

      it 'returns a hash of string keys if the given keys are strings' do
        h = {"key_one" => "val_one", "key_two" => "val_two"}
        CollectionBuilder.new.stringify_keys(h).must_equal({"key_one" => "val_one", "key_two" => "val_two"})
      end

      it 'returns a hash of string keys if one key is a string and one is a symbol' do
        h = {"key_one" => "val_one", key_two: "val_two"}
        CollectionBuilder.new.stringify_keys(h).must_equal({"key_one" => "val_one", "key_two" => "val_two"})
      end

      it 'returns an empty hash if the given hash is empty' do
        h = {}
        CollectionBuilder.new.stringify_keys(h).must_equal({})
      end
    end
  end
end
