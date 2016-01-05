require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require_relative '../../lib/vault-tree'

#  This contract introduces the idea of a Block Chain key transfer.
#  This can might be used as step within the execution of a larger application
#  that interacts with the Bitcoin Block Chain.
#
#  Goal:
#    * Two parties wish to transfer the BTC signing key associated with a particular wallet address
#    * To effect this transfer they want to use only a Vault Tree JSON files and the BTC Block Chain
#    * The transfering party wants to maintain control over the precise moment the signing key is
#      released to the receiving party.
#
#  Ideas:
#    * The sending party can use the hash digest of a Block Chain wallet address
#      as the symmetric locking key to a vault.
#    * After generating a hidden wallet address, the sender can use the address to lock the BTC signing
#      key in the vault.
#    * By spending Bitcoins from an origin wallet address (that is know the receiver) to the hidden
#      destination wallet address, the sending party is able to Reveal the encryption key needed to
#      unlock the symmetric vault.
#
#  Notes:
#    * This transfer could prove useful as a step in a more sophisticated contract.
#    * Here we are transfering a BTC Signing Key. This approach could work to transfer any
#      type of private information.
#    * Transfering Signed but Unbroadcasted transactions with this mechanism could open up
#      many new possibilities.
describe 'Block Chain Key Transfer Collection' do
  before do
    @receiver_secret  = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
    @sender_secret    = 'a361c0cd81174a040a4701572747273ae18dbc4a57a8b602371724fce9e063e0'
    @sender_origin_wallet_address = '1XJEBF8EUBF855NEBHVENPFE9JE74E'
    @sender_concealed_destination_wallet_address = '1JVKE8HD5JDHFEJHF678JEH8DEJGHE'
    @sender_concealed_destination_wallet_address_digest = VaultTree::LockSmith.new(message: @sender_concealed_destination_wallet_address).secure_hash
    @sender_btc_signing_key = 'BITCOIN_SIGNING_KEY_KEEP_IT_SECRET'
  end

  it 'blank collection validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', blank_collection, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end

  it 'sender and receiver work together to execute the collection' do
    # Given the blank vault collection:
    json_collection = blank_collection # defined below

    #  Given the SENDER has the blank contract template
    #  And the SENDER chooses an origin address and a concealed destination address
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close sender_concealed_destination_wallet_address_digest scdwa=#{@sender_concealed_destination_wallet_address_digest} ss_key=#{@sender_secret}`
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close sender_origin_wallet_address sowa=#{@sender_origin_wallet_address} ss_key=#{@sender_secret}`

    #  And he locks away the secret BTC signing key
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close sender_btc_signing_key ssk=#{@sender_btc_signing_key} ss_key=#{@sender_secret}`

    #  When the SENDER transfers the collection to the RECEIVER
    #  Then the RECEIVER can access the origin wallet address
    recovered_origin_wallet_address = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt open sender_origin_wallet_address rs_key=#{@receiver_secret}`
    assert_equal @sender_origin_wallet_address, recovered_origin_wallet_address

    #  When the SENDER reveals the hidden wallet address by transfering bitcoins from the origin address
    wallet_address_from_watching_blockchain = @sender_concealed_destination_wallet_address # This is made public on the block chain

    # Then the RECEIVER can compute its digest
    revealed_destination_wallet_address_digest = VaultTree::LockSmith.new(message: wallet_address_from_watching_blockchain).secure_hash

    # And Lock the digest in its Vault
    json_collection = `VAULTS='#{json_collection}'; echo $VAULTS | ./bin/vt close revealed_destination_wallet_address_digest rs_key=#{@receiver_secret} rdwad=#{revealed_destination_wallet_address_digest }`

    #  And the RECEIVER can unlock the vault to recover the transfered signing key
    transfered_secret_key = `VAULTS='#{json_collection}'; echo $VAULTS | ./bin/vt open sender_btc_signing_key rs_key=#{@receiver_secret} rs_key=#{@receiver_secret}`

    # And can use the key to spend bitcoins
    assert_equal @sender_btc_signing_key, transfered_secret_key
  end

  def blank_collection

    # sender_btc_signing_key:
    #   This is the secret Bitcoin Signing Key that SENDER wishes to transfer
    #   to RECEIVER. The RECEIVER can unlock only after he has the revealed address.

    # sender_origin_wallet_address:
    #   SENDER origin wallet address. Chosen by SENDER and known
    #   in advance to RECEIVER.

    # sender_concealed_destination_wallet_address:
    #  "SENDER concealed copy of the destination wallet address. This wallet
    #  address is kept secret until SENDER chosed to transfer BTC to it",

    # revealed_destination_wallet_address_digest
    #   RECEIVER monitors the Block Chain and fills this vault with a secure
    #   hash of the newly revealied destination address

    #  sender_secret:
    #    Contract specific password for SENDER. Used to Lock the
    #    SENDER private information

    #  receiver_secret:
    #    Contract specific password for RECEIVER. Used to Lock the
    #    RECEIVER private information

    %Q[
    {
      "vaults": {

        "sender_btc_signing_key":{
          "contents":   {"external_input": "ssk"},
          "lock_key":   {"sym_key":{"vault_contents":"sender_concealed_destination_wallet_address_digest"}},
          "unlock_key": {"sym_key":{"vault_contents":"revealed_destination_wallet_address_digest"}},
          "ciphertext": ""
        },

        "sender_origin_wallet_address":{
          "contents":   {"external_input": "sowa"},
          "lock_key":   {"sym_key": {"open_key":"sym_key"}},
          "unlock_key": {"sym_key": {"open_key":"sym_key"}},
          "ciphertext": ""
        },

        "sender_concealed_destination_wallet_address_digest":{
          "contents":   {"external_input": "scdwa"},
          "lock_key":   {"sym_key": {"vault_contents":"sender_secret"}},
          "unlock_key": {"sym_key": {"vault_contents":"sender_secret"}},
          "ciphertext": ""
        },

        "revealed_destination_wallet_address_digest":{
          "contents":   {"external_input": "rdwad"},
          "lock_key":   {"sym_key": {"vault_contents":"receiver_secret"}},
          "unlock_key": {"sym_key": {"vault_contents":"receiver_secret"}},
          "ciphertext": ""
        },

        "receiver_secret":{
          "contents":   {"random_key": "sym_key"},
          "lock_key":   {"sym_key": {"external_input": "rs_key"}},
          "unlock_key": {"sym_key": {"external_input": "rs_key"}},
          "ciphertext": ""
        },

        "sender_secret":{
          "contents":   {"random_key": "sym_key"},
          "lock_key":   {"sym_key": {"external_input": "ss_key"}},
          "unlock_key": {"sym_key": {"external_input": "ss_key"}},
          "ciphertext": ""
        }
      }
    }
    ]
  end
end
