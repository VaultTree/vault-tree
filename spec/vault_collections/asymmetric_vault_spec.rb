require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require_relative '../../lib/vault-tree'

#  Asymmetric Vaults
#
#  Goals:
#    * Illustrate the use of an Asymmetric Vault
#    * Understand the DH_KEY reserved word
#    * Illustrate an implementation of Public Key Encryption with Mutual Authentication
#      via the ECDH algorithm
#
#  Ideas:
#    * Notice in the contract that the Locking DH_KEY is formed with
#      a private key, and the public key of the reciprocal party
#    * The cooresponding Unlocking DH_KEY is built and authenticated with a private
#      key and the reciprocal public key
describe 'Asymmetric Vaults Collection' do
  before do
    @msg = "The_Really_Secret_Message!"
    # TODO: # Be careful with using spaces in messages.
    # There are some commandline parsing issues.
    @acs_key = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
    @bcs_key = 'a361c0cd81174a040a4701572747273ae18dbc4a57a8b602371724fce9e063e0'
  end

  it 'blank collection validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', blank_collection, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end

  it 'Alice and Bob work together to execute the collection' do
    # Given the blank vault collection:
    json_collection = blank_collection # defined below

    # When she locks all of her public and private attributes:
    #    she lock here asym private key
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close alice_decryption_key acs=#{@acs_key}`
    #    she generates and locks here asym pub key
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close alice_public_encryption_key acs=#{@acs_key}`

    #  And she sends the contract to Bob over the internet
    #  Then Bob can access of her public keys but not her private keys
    alice_public_key = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt open alice_public_encryption_key`
    assert_equal alice_public_key.is_a?(String), true; assert_equal alice_public_key.empty?, false;

    #  When Bob locks his public and private keys
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close bob_decryption_key bcs=#{@bcs_key}`
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close bob_public_encryption_key bcs=#{@bcs_key}`

    #  And He fills and locks the vault containing the message using a DH_KEY
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close message msg=#{@msg} bcs=#{@bcs_key}`

    #  And he sends the contract back to Alice over the internet
    #  Then Alice can unlock the message with a DH_KEY
    recovered_message = `VAULTS='#{json_collection}'; echo $VAULTS | ./bin/vt open message acs=#{@acs_key}`
    assert_equal recovered_message, @msg
  end

  def blank_collection

    # bob_contract_secret:
    #  Contract specific password to lock private information
%Q[
  {
    "vaults":{
      "message": {
        "contents": {
          "external_input": "msg"
        },
        "lock_key": {
          "asym_pub_key": { "vault_contents": "alice_public_encryption_key" },
          "asym_prv_key": { "vault_contents": "bob_decryption_key" }
        },
        "unlock_key": {
          "asym_pub_key": { "vault_contents": "bob_public_encryption_key" },
          "asym_prv_key": { "vault_contents": "alice_decryption_key" }
        },
        "ciphertext": ""
      },
      "bob_public_encryption_key": {
        "contents": {
          "computed_pub_key": {
            "vault_contents": "bob_decryption_key"
          }
        },
        "lock_key": {
          "sym_key": {
            "open_key": "sym_key"
          }
        },
        "unlock_key": {
          "sym_key": {
            "open_key": "sym_key"
          }
        },
        "ciphertext": ""
      },
      "bob_decryption_key": {
        "contents": {
          "random_key": "asym_prv_key"
        },
        "lock_key": {
          "sym_key": {
            "external_input": "bcs"
          }
        },
        "unlock_key": {
          "sym_key": {
            "external_input": "bcs"
          }
        },
        "ciphertext": ""
      },
      "alice_public_encryption_key": {
        "contents": {
          "computed_pub_key": {
            "vault_contents": "alice_decryption_key"
          }
        },
        "lock_key": {
          "sym_key": {
            "open_key": "sym_key"
          }
        },
        "unlock_key": {
          "sym_key": {
            "open_key": "sym_key"
          }
        },
        "ciphertext": ""
      },
      "alice_decryption_key": {
        "contents": {
          "random_key": "asym_prv_key"
        },
        "lock_key": {
          "sym_key": {
            "external_input": "acs"
          }
        },
        "unlock_key": {
          "sym_key": {
            "external_input": "acs"
          }
        },
        "ciphertext": ""
      }
    }
  }
    ]
  end
end
