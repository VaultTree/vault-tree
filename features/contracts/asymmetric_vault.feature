Feature: Asymmetric Vaults

  Goals:
    * Illustrate the use of an Asymmetric Vault
    * Understand the DH_KEY reserved word
    * Illustrate an implementation of Public Key Encryption with Mutual Authentication
      via the ECDH algorithm

  Ideas:
    * Notice in the contract that the Locking DH_KEY is formed with
      a private key, and the public key of the reciprocal party
    * The cooresponding Unlocking DH_KEY is built and authenticated with a private
      key and the reciprocal public key

Scenario: Bob Locks and Alice Unlocks with a Shared Key
  Given the blank contract:
    """javascript
      {
        "header": {
          "title":"Asymmetric Vault",
          "description":"Demonstrated use of a Vault Tree Asymmetric Vault"
        },
        "vaults": {
          "bob_contract_secret":{
            "description":"Contract specific password to lock private information",
            "contents": "RANDOM_KEY",
            "lock_key": "EXTERNAL_INPUT['bcs_key']",
            "unlock_key": "EXTERNAL_INPUT['bcs_key']",
            "ciphertext": ""
          },

          "alice_contract_secret":{
            "description":"Contract specific password to lock private information",
            "contents": "RANDOM_KEY",
            "lock_key": "EXTERNAL_INPUT['acs_key']",
            "unlock_key": "EXTERNAL_INPUT['acs_key']",
            "ciphertext": ""
          },

          "alice_public_encryption_key":{
            "description":"Public key for asymmetric encryption",
            "contents": "PUBLIC_ENCRYPTION_KEY['alice_decryption_key']",
            "lock_key": "UNLOCKED",
            "unlock_key": "UNLOCKED",
            "ciphertext": ""
          },

          "bob_public_encryption_key":{
            "description":"Public key for asymmetric encryption",
            "contents": "PUBLIC_ENCRYPTION_KEY['bob_decryption_key']",
            "lock_key": "UNLOCKED",
            "unlock_key": "UNLOCKED",
            "ciphertext": ""
          },

          "alice_decryption_key":{
            "description":"Private key for asymmetric decryption",
            "contents": "DECRYPTION_KEY",
            "lock_key": "KEY['alice_contract_secret']",
            "unlock_key": "KEY['alice_contract_secret']",
            "ciphertext": ""
          },

          "bob_decryption_key":{
            "description":"Private key for asymmetric decryption",
            "contents": "DECRYPTION_KEY",
            "lock_key": "KEY['bob_contract_secret']",
            "unlock_key": "KEY['bob_contract_secret']",
            "ciphertext": ""
          },

          "message":{
            "description":"This is an asymmetric vault. It contains a secret message.",
            "contents": "EXTERNAL_INPUT['msg']",
            "lock_key": "DH_KEY['alice_public_encryption_key','bob_decryption_key']",
            "unlock_key": "DH_KEY['bob_public_encryption_key','alice_decryption_key']",
            "ciphertext": ""
          }


        }
      }
    """
  When Alice locks all of her public and private keys
  And she sends the contract to Bob over the internet
  Then Bob can access of her public keys but not her private keys
  When Bob locks his public and private keys
  And He fills and locks the vault containing the message using a DH_KEY
  And he sends the contract back to Alice over the internet
  Then Alice can unlock the message with a DH_KEY
