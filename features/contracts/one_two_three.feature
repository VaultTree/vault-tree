Feature: One-Two-Three Contract

  Goal:
    * Used to demonstrate and test basic Vault Tree functionality
    * It nicely illustrates how vault keys can be arranged to enforce the terms of a contract 
    * If you are new to the Vault Tree Library it may be helpful to study the details of this contract
      to gain a better understanding of the core concepts.

  Ideas:
    * Bob sets up a simple Scavenger Hunt for Alice
    * He locks a Congratulations Message in the final vault
    * In order to get to the final message Alice needs to unlock the preceeding vaults with the
      appropriate keys

Scenario: Alice and Bob Execute the One Two Three Contract
  Given the blank contract:
    """javascript
      {
        "header": {
          "title":"One Two Three",
          "description":"A simple contract to test the full Vault Tree stack. Open each vault to proceed to the next one. Unlock the congratulations message"
        },
        "vaults": {

          "bob_contract_secret":{
            "description":"contract specific password to lock private information",
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          },

          "alice_contract_secret":{
            "description":"contract specific password to lock private information",
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          },

          "alice_public_encryption_key":{
            "description":"public key for asymmetric encryption",
            "fill_with": "PUBLIC_ENCRYPTION_KEY['alice_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "bob_public_encryption_key":{
            "description":"public key for asymmetric encryption",
            "fill_with": "PUBLIC_ENCRYPTION_KEY['bob_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "alice_decryption_key":{
            "description":"private key for asymmetric decryption",
            "fill_with": "DECRYPTION_KEY",
            "lock_with": "KEY['alice_contract_secret']",
            "unlock_with": "KEY['alice_contract_secret']",
            "contents": ""
          },

          "bob_decryption_key":{
            "description":"private key for asymmetric decryption",
            "fill_with": "DECRYPTION_KEY",
            "lock_with": "KEY['bob_contract_secret']",
            "unlock_with": "KEY['bob_contract_secret']",
            "contents": ""
          },

          "congratulations_message":{
            "description":"A simple message for Bob to put in the final vault",
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "KEY['bob_contract_secret']",
            "unlock_with": "KEY['bob_contract_secret']",
            "contents": ""
          },

          "vault_two_key":{
            "description":"Key to lock vault two. Once Bob locks the second vault he will put this key inside vault one.",
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "KEY['bob_contract_secret']",
            "unlock_with": "KEY['bob_contract_secret']",
            "contents": ""
          },

          "vault_three_key":{
            "description":"Key to lock vault three. Once Bob locks the third vault he will put this key inside vault two.",
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "KEY['bob_contract_secret']",
            "unlock_with": "KEY['bob_contract_secret']",
            "contents": ""
          },

          "first":{
            "description":"This is an asymmetric vault with mutual authentication. It contains the key to vault two and is locked by Bob, with Alices public key. Only Alice can unlock it.",
            "fill_with": "KEY['vault_two_key']",
            "lock_with": "DH_KEY['alice_public_encryption_key','bob_decryption_key']",
            "unlock_with": "DH_KEY['bob_public_encryption_key','alice_decryption_key']",
            "contents": ""
          },

          "second":{
            "description":"Alice unlocks this vault with the key held in the first vault.",
            "fill_with": "KEY['vault_three_key']",
            "lock_with": "KEY['vault_two_key']",
            "unlock_with": "KEY['first']",
            "contents": ""
          },

          "third":{
            "description":"Contains a simple message. Unlock the key found in the second vault.",
            "fill_with": "KEY['congratulations_message']",
            "lock_with": "KEY['vault_three_key']",
            "unlock_with": "KEY['second']",
            "contents": ""
          }

        }
      }
    """
  And Alice has the blank contract
  When she locks all of her attributes
  And she sends the contract to Bob
  Then Bob can access all of her public attributes
  When Bob locks his attributes
  And He fills and locks each of the three main vaults
  Then Alice can execute the contract to recover the final message
