Feature: Random Number

The keyword

```javascript
RANDOM_NUMBER
```

behaves as expected.

When used, the Vault Tree library generates a Cryptographic Hash of a random number and places it in the designated vault.

You should use this keyword to build secure symmetric Vault keys.

Scenario: Close And Open With Random Key
  Given the blank contract:
    """javascript
      {
        "header": {
          "title":"Close And Open With Random Key"
        },
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
            "lock_with": "KEY['random_vault_key']",
            "unlock_with": "KEY['random_vault_key']",
            "contents": ""
          }

        }
      }
    """
  When I lock away a random vault key
  And I use the random key to lock a message
  Then I can recover the message with the Random Key
