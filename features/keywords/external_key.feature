Feature: External Key

  Scenario: Close And Open Using and External Key
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {
            "message":{
              "description": "Simple Congratulations Message",
              "fill_with": "EXTERNAL_INPUT['msg']",
              "lock_with": "EXTERNAL_KEY['secret']",
              "unlock_with": "EXTERNAL_KEY['secret']",
              "contents": ""
            }
          }
        }
      """
    When I lock the external input in a vault using an external key
    Then I can recover the input message using the same key
