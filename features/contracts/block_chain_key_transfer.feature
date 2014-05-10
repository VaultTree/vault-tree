Feature: Block Chain Key Transfer

  This contract introduces the idea of a Bitcoin key transfer.

  Goal:
    * Two parties wish to transfer the BTC signing key associated with a particular wallet address
    * To effect this transfer they want to use only a Vault Tree JSON files and the BTC Block Chain
    * The transfering party wants to maintain control over the precise moment the signing key is
      released to the receiving party.

  Ideas:
    * The sending party can use a Block Chain wallet address as the locking key to a symmetric vault.
    * After generating a hidden wallet address, the sender can use the address to lock the BTC signing
      key in the vault.
    * By spending Bitcoins from an origin wallet address (that is know the receiver) to the hidden
      destination wallet address, the sending party is able to Reveal the encryption key needed to
      unlock the symmetric vault.

  Notes:
    * This transfer could prove useful as a step in a more sophisticated contract.
    * Here we are transfering a BTC Signing Key. This approach could work to transfer any
      type of private information.
    * Transfering Signed but Unbroadcasted transactions with this mechanism could open up
      many new possibilities.

Scenario: SENDER Transfers a BTC Signing Key to the RECEIVER

  Given the blank contract:
    """javascript
      {
        "header": {
          "title":"Block Chain Key Transfer",
          "description":"A simple key transfer sheme utilizing a revealed BTC Wallet Address. This can be used as step within the execution of a larger contract."
        },
        "vaults": {

        "sender_btc_signing_key":{
          "description":"This is the secret Bitcoin Signing Key that SENDER wishes to transfer to RECEIVER. The RECEIVER can unlock only after he has the revealed address.",
          "fill_with": "EXTERNAL_DATA",
          "lock_with": "KEY['sender_concealed_destination_wallet_address']",
          "unlock_with": "KEY['receiver_revealed_destination_wallet_address']",
          "contents": ""
        },

        "sender_origin_wallet_address":{
          "description":"SENDER origin wallet address. Chosen by SENDER and known in advance to RECEIVER.",
          "fill_with": "EXTERNAL_DATA",
          "lock_with": "UNLOCKED",
          "unlock_with": "UNLOCKED",
          "contents": ""
        },

        "sender_concealed_destination_wallet_address":{
          "description":"SENDER concealed copy of the destination wallet address. This wallet address is kept secret until SENDER chosed to transfer BTC to it",
          "fill_with": "EXTERNAL_DATA",
          "lock_with": "KEY['sender_secret']",
          "unlock_with": "KEY['sender_secret']",
          "contents": ""
        },

        "receiver_revealed_destination_wallet_address":{
          "description":"RECEIVER monitors the Block Chain and fills this vault with the newly revealied destination address.",
          "fill_with": "EXTERNAL_DATA",
          "lock_with": "KEY['receiver_secret']",
          "unlock_with": "KEY['receiver_secret']",
          "contents": ""
        },

        "receiver_secret":{
          "fill_with": "RANDOM_NUMBER",
          "lock_with": "EXTERNAL_DATA",
          "unlock_with": "EXTERNAL_DATA",
          "contents": ""
        },

        "sender_secret":{
          "description":"Contract specific password for SENDER. Used to Lock the SENDER private information.",
          "fill_with": "RANDOM_NUMBER",
          "lock_with": "EXTERNAL_DATA",
          "unlock_with": "EXTERNAL_DATA",
          "contents": ""
        }

      }
    }
    """
  Given the SENDER has the blank contract template
  And the SENDER chooses an origin address and a concealed destination address
  And he locks away the secret BTC signing key
  When the SENDER transfers the contract to the RECEIVER
  Then the RECEIVER can access the origin wallet address
  When the SENDER reveals the hidden wallet address by transfering bitcoins from the origin address
  Then the RECEIVER can unlock the vault to recover the transfered signing key
