Feature: Key

  This keyword is an alias of the the `CONTENTS` keyword:

  ```javascript
  KEY['vault_id']
  ```

  Note that:
    * It should be used specifically when the contents are a Symmetric vault key.
    * It takes one argument, the name of the vault holding the desired string.
    * The `KEY` keyword can be used in the **fill_with**, **lock_with** and **unlock_with** fields.

  Scenario: Close And Open Using with a Key
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {
            "random_vault_key":{
              "description":"Random Number",
              "fill_with": "RANDOM_NUMBER",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
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
    When I lock a message in a vault using a symmetric vault key
    Then I can recover the message using the same key
