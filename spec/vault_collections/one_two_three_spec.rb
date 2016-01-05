require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require_relative '../../lib/vault-tree'


#  Goal:
#    * Used to demonstrate and test basic Vault Tree functionality
#
#    * It nicely illustrates how vault keys can be arranged for enforcement.
#      Almost like terms in a contract.
#
#    * If you are new to the Vault Tree Library it may be helpful to study
#      the details of this collection to gain a better understanding
#      of the core concepts.
#
#  Ideas:
#    * Bob sets up a simple Scavenger Hunt for Alice
#
#    * He locks a Congratulations Message in the final vault
#
#    * In order to get to the final message Alice needs to unlock the preceeding vaults with the
#      appropriate keys
describe 'One Two Three Vault Collection' do
  before do
    @msg = "The_Secret_Message!"
    # TODO: # Be careful with using spaces in messages.
    # There are some commandline parsing issues.
    @acs_key = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
    @bcs_key = 'a361c0cd81174a040a4701572747273ae18dbc4a57a8b602371724fce9e063e0'
    @shell_setup = "VAULTS='#{blank_collection}'; vt(){ ./bin/vt ; }"
  end

  it 'blank collection validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', blank_collection, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end

  it 'Alice and Bob work together to execute the collection' do
    # Given the blank vault collection:
    @json_collection = blank_collection # defined below
    # And Alice receives the blank vault collection

    # When she locks all of her public and private attributes
    #    she lock here asym private key
    @json_collection = `VAULTS='#{blank_collection}';  echo $VAULTS | ./bin/vt close alice_decryption_key acs=#{@acs_key}`
    #    she generates and locks here asym pub key
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close alice_public_encryption_key acs=#{@acs_key}`

    # And she forwards the collection to Bob
    #
    # Then Bob is able to access all of her public key
    # no secrets are needed here. alice exposed her public key by locking
    # it with the "open_key"
    @alice_public_key = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt open alice_public_encryption_key`
    assert_equal @alice_public_key.is_a?(String), true; assert_equal @alice_public_key.empty?, false;

    # When Bob locks up his attributes

    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close bob_decryption_key bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close bob_public_encryption_key bcs=#{@bcs_key}`

    #  And He fills and then locks each of the three vaults
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close congratulations_message msg=#{@msg} bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close vault_two_key bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close vault_three_key bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close third bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close second bcs=#{@bcs_key}`
    @json_collection = `VAULTS='#{@json_collection}';  echo $VAULTS | ./bin/vt close first bcs=#{@bcs_key}`

    # Then Alice can execute the collection to recover the the locked message
    # in one step by asking for the contents of the third vault
    @recovered_message = `VAULTS='#{@json_collection}'; echo $VAULTS | ./bin/vt open third acs=#{@acs_key}`
    assert_equal @recovered_message, @msg
  end
end

def blank_collection
%Q[
  {
    "vaults":{
      "congratulations_message": {
        "contents": {
          "external_input": "msg"
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
      "vault_two_key": {
        "contents": {
          "random_key": "sym_key"
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
      "vault_three_key": {
        "contents": {
          "random_key": "sym_key"
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
      "first": {
        "contents": {
          "vault_contents": "vault_two_key"
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
      "second": {
        "contents": {
          "vault_contents": "vault_three_key"
        },
        "lock_key": {
          "sym_key": {
            "vault_contents": "vault_two_key"
          }
        },
        "unlock_key": {
          "sym_key": {
            "vault_contents": "first"
          }
        },
        "ciphertext": ""
      },
      "third": {
        "contents": {
          "vault_contents": "congratulations_message"
        },
        "lock_key": {
          "sym_key": {
            "vault_contents": "vault_three_key"
          }
        },
        "unlock_key": {
          "sym_key": {
            "vault_contents": "second"
          }
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
