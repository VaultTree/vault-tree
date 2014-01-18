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
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "DH_KEY['another_public_key','my_decryption_key']",
            "unlock_with": "DH_KEY['my_public_key','another_decryption_key']",
            "contents": ""
          },
          "my_decryption_key":{
            "fill_with": "DECRYPTION_KEY",
            "lock_with": "MASTER_PASSPHRASE",
            "unlock_with": "MASTER_PASSPHRASE",
            "contents": ""
          },
          "my_public_key":{
            "fill_with": "PUBLIC_ENCRYPTION_KEY['my_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "another_decryption_key":{
            "fill_with": "DECRYPTION_KEY",
            "lock_with": "MASTER_PASSPHRASE",
            "unlock_with": "MASTER_PASSPHRASE",
            "contents": ""
          },
          "another_public_key":{
            "fill_with": "PUBLIC_ENCRYPTION_KEY['another_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  And I have access to the another user's unlocked public key
  And I lock a simple message with a DH Key
  When I transfer the contract to the other user
  Then they can create a DH Key and unlock the message
