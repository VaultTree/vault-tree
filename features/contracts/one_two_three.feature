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
            "contents": "RANDOM_KEY",
            "lock_key": "EXTERNAL_INPUT['bcs_key']",
            "unlock_key": "EXTERNAL_INPUT['bcs_key']",
            "ciphertext": ""
          },

          "alice_contract_secret":{
            "description":"contract specific password to lock private information",
            "contents": "RANDOM_KEY",
            "lock_key": "EXTERNAL_INPUT['acs_key']",
            "unlock_key": "EXTERNAL_INPUT['acs_key']",
            "ciphertext": ""
          },

          "alice_public_encryption_key":{
            "description":"public key for asymmetric encryption",
            "contents": "PUBLIC_ENCRYPTION_KEY['alice_decryption_key']",
            "lock_key": "UNLOCKED",
            "unlock_key": "UNLOCKED",
            "ciphertext": ""
          },

          "bob_public_encryption_key":{
            "description":"public key for asymmetric encryption",
            "contents": "PUBLIC_ENCRYPTION_KEY['bob_decryption_key']",
            "lock_key": "UNLOCKED",
            "unlock_key": "UNLOCKED",
            "ciphertext": ""
          },

          "alice_decryption_key":{
            "description":"private key for asymmetric decryption",
            "contents": "DECRYPTION_KEY",
            "lock_key": "KEY['alice_contract_secret']",
            "unlock_key": "KEY['alice_contract_secret']",
            "ciphertext": ""
          },

          "bob_decryption_key":{
            "description":"private key for asymmetric decryption",
            "contents": "DECRYPTION_KEY",
            "lock_key": "KEY['bob_contract_secret']",
            "unlock_key": "KEY['bob_contract_secret']",
            "ciphertext": ""
          },

          "congratulations_message":{
            "description":"A simple message for Bob to put in the final vault",
            "contents": "EXTERNAL_INPUT['msg']",
            "lock_key": "KEY['bob_contract_secret']",
            "unlock_key": "KEY['bob_contract_secret']",
            "ciphertext": ""
          },

          "vault_two_key":{
            "description":"Key to lock vault two. Once Bob locks the second vault he will put this key inside vault one.",
            "contents": "RANDOM_KEY",
            "lock_key": "KEY['bob_contract_secret']",
            "unlock_key": "KEY['bob_contract_secret']",
            "ciphertext": ""
          },

          "vault_three_key":{
            "description":"Key to lock vault three. Once Bob locks the third vault he will put this key inside vault two.",
            "contents": "RANDOM_KEY",
            "lock_key": "KEY['bob_contract_secret']",
            "unlock_key": "KEY['bob_contract_secret']",
            "ciphertext": ""
          },

          "first":{
            "description":"This is an asymmetric vault with mutual authentication. It contains the key to vault two and is locked by Bob, with Alices public key. Only Alice can unlock it.",
            "contents": "CONTENTS['vault_two_key']",
            "lock_key": "DH_KEY['alice_public_encryption_key','bob_decryption_key']",
            "unlock_key": "DH_KEY['bob_public_encryption_key','alice_decryption_key']",
            "ciphertext": ""
          },

          "second":{
            "description":"Alice unlocks this vault with the key held in the first vault.",
            "contents": "CONTENTS['vault_three_key']",
            "lock_key": "KEY['vault_two_key']",
            "unlock_key": "KEY['first']",
            "ciphertext": ""
          },

          "third":{
            "description":"Contains a simple message. Unlock the key found in the second vault.",
            "contents": "CONTENTS['congratulations_message']",
            "lock_key": "KEY['vault_three_key']",
            "unlock_key": "KEY['second']",
            "ciphertext": ""
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
