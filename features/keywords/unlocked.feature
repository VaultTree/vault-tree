Feature: Unlocked

```javascript
  "lock_with": "UNLOCKED",
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
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "MASTER_PASSPHRASE",
            "unlock_with": "MASTER_PASSPHRASE",
            "contents": ""
            },
          "message_locked_with_random":{
            "description":"A simple message locked with a random number",
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "CONTENTS['random_vault_key']",
            "unlock_with": "CONTENTS['random_vault_key']",
            "contents": ""
          },
          "unlocked_random_key":{
            "description":"An unlocked random key",
            "fill_with": "CONTENTS['random_vault_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "message_locked_with_unlocked_random_number":{
            "fill_with": "CONTENTS['message_locked_with_random']",
            "lock_with": "CONTENTS['unlocked_random_key']",
            "unlock_with": "CONTENTS['unlocked_random_key']",
            "contents": ""
          }
        }
      }
    """
  When I lock away a random vault key
  And I use the random key to lock a message
  And I put this random key in an unlocked vault
  Then another user can recover the message with the Unlocked Random Key
