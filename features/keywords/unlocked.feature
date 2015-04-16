Feature: Unlocked

```javascript
  "lock_key": "UNLOCKED",
  "unlock_with": "UNLOCKED"
```

This keyword should be used to make vault contents accessable to anyone.

When the contract interpreter reads this keyword it simply hashes the actual string _"UNLOCKED"_ and uses the resulting digest as the symmetric vault key.

Scenario: Transfer Key Via Unlocked Vault
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "random_vault_key":{
            "description":"Random Number",
            "contents": "RANDOM_KEY",
            "lock_key": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
            },
          "message_locked_with_random":{
            "description":"A simple message locked with a random number",
            "contents": "EXTERNAL_INPUT['msg']",
            "lock_key": "KEY['random_vault_key']",
            "unlock_with": "KEY['random_vault_key']",
            "ciphertext": ""
          },
          "unlocked_random_key":{
            "description":"An unlocked random key",
            "contents": "KEY['random_vault_key']",
            "lock_key": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "ciphertext": ""
          },
          "message_locked_with_unlocked_random_number":{
            "contents": "CONTENTS['message_locked_with_random']",
            "lock_key": "KEY['unlocked_random_key']",
            "unlock_with": "KEY['unlocked_random_key']",
            "ciphertext": ""
          }
        }
      }
    """
  When I lock away a random vault key
  And I use the random key to lock a message
  And I put this random key in an unlocked vault
  Then another user can recover the message with the Unlocked Random Key
