Feature: External Key

  EXTERNAL_KEY ensures your password is run through a secure hash before it is used to
  lock contents. Hashing guarentees a properly padded vault key and keeps the locked vault
  more secure if you have a weak password.

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
              "ciphertext": ""
            }
          }
        }
      """
    When I lock the external input in a vault using an external key
    Then I can recover the input message using the same key
