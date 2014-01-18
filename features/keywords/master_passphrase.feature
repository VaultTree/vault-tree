Feature: Master Passphrase

```javascript
"lock_with": "MASTER_PASSPHRASE",
"unlock_with": "MASTER_PASSPHRASE"
```

The master password can be thought of as the secure password for the system that is executing the contract. It should never be shared or transfered between parties.

Vault Tree prevents this value from ever being stored within a vault. If you attempt to store the master password within a vault, an exception will be thrown.

As a best practice you should minimize the number of vaults that are locked or
unlocked with your master password. Specifically, consider randomly generating a
contract secret and then locking it with your master password. Then you can lock
other vaults with this randomly generated ephemeral secret when you want store
confidential contract data.

Scenario: Close And Open With Master Password
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
          "message":{
            "description": "Simple Congratulations Message",
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "KEY['random_vault_key']",
            "unlock_with": "KEY['random_vault_key']",
            "contents": ""
          }
        }
      }
    """
  When I lock a message in a vault with my Master Password
  Then I can recover the message with my Master Password

Scenario: Missing Passphrase
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
          "message":{
            "description": "Simple Congratulations Message",
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "KEY['random_vault_key']",
            "unlock_with": "KEY['random_vault_key']",
            "contents": ""
          }
        }
      }
    """
  When I attempt fill a vault without providing a master passphrase
  Then a MissingPassphrase exception is raised
