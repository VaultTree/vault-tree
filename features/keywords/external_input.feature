Feature: External Inputs

The Vault Tree interpreter does not interact directly with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that all necessary external inputs will be explicitly passed in.

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
              "fill_with": "EXTERNAL_INPUT['msg']",
              "lock_with": "KEY['random_vault_key']",
              "unlock_with": "KEY['random_vault_key']",
              "contents": ""
            }
          }
        }
      """
    When I lock the external input in a vault using a symmetric vault key
    Then I can recover the input message using the same key
