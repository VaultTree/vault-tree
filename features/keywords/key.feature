Feature: Key

  `KEY` fetches the contents from the specified vault and performs a secure hash on the result.

  ```javascript
  KEY['vault_id']
  ```

  Note that:
    * It should be used specifically when the contents are a Symmetric vault key.
    * It takes one argument, the name of the vault holding the desired string.
    * The `KEY` keyword can be used in the **"contents"**, **"lock_key"** and **"unlock_with"** fields.

  Scenario: Close And Open Using with a Key
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
            "message":{
              "description": "Simple Congratulations Message",
              "contents": "EXTERNAL_INPUT['msg']",
              "lock_key": "KEY['random_vault_key']",
              "unlock_with": "KEY['random_vault_key']",
              "ciphertext": ""
            }
          }
        }
      """
    When I lock a message in a vault using a symmetric vault key
    Then I can recover the message using the same key
