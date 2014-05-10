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
            "message":{
              "description": "Simple Congratulations Message",
              "fill_with": "EXTERNAL_INPUT['msg']",
              "lock_with": "EXTERNAL_INPUT['secret']",
              "unlock_with": "EXTERNAL_INPUT['secret']",
              "contents": ""
            }
          }
        }
      """
    When I lock the external input in a vault using a symmetric vault key
    Then I can recover the input message using the same key
