Feature: DH Key

```javascript
DH_KEY['public_key_vault_id','decryption_key_vault_id']
```
This keyword enables the creation of **Asymmetric Vaults**.

DH Keys are very powerful and Vault Tree is written to encourage contract authors to make use of asymmetric encryption.

The underlying cryptographic library provides a set of expertly crafted opinionated conventions for using public keys. One such convention is [Mutual Authentication](http://en.wikipedia.org/wiki/Mutual_authentication) accomplished with the Elliptic Curve Diffie-Hellman key exchange protocol.

Feel free to study the example contracts for some good ideas on how to use this powerful keyword.

Scenario: Asymmetric Vault
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "asymmetric_message":{
            "contents": "EXTERNAL_INPUT['asymmetric_message']",
            "lock_with": "DH_KEY['another_public_key','my_decryption_key']",
            "unlock_with": "DH_KEY['my_public_key','another_decryption_key']",
            "ciphertext": ""
          },
          "my_decryption_key":{
            "contents": "DECRYPTION_KEY",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
          },
          "my_public_key":{
            "contents": "PUBLIC_ENCRYPTION_KEY['my_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
          },
          "another_decryption_key":{
            "contents": "DECRYPTION_KEY",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
          },
          "another_public_key":{
            "contents": "PUBLIC_ENCRYPTION_KEY['another_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
          }
        }
      }
    """
  And I have access to the another user's unlocked public key
  And I lock a simple message with a DH Key
  When I transfer the contract to the other user
  Then they can create a DH Key and unlock the message
