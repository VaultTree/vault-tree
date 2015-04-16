Feature: External Inputs

The Vault Tree interpreter does not interact directly with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that all necessary external inputs will be explicitly passed in.

Use the EXTERNAL_INPUT Keyword when you want to fill a vault with a string from
the outside environment.

Although you can lock and unlock vaults directly with an EXTERNAL_INPUT string
if it happens to be properly formated, it is recommended that you do not do this.

Instead, lock and unlock vaults with external strings using the EXTERNAL_KEY phrase.
EXTERNAL_KEY ensures your password is run through a secure hash before it is used to
lock contents. Hashing guarentees a properly padded vault key and keeps the locked vault
more secure if you have a weak password.

  Scenario: Close And Open Using with a Key
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {
            "message":{
              "description": "Simple Congratulations Message",
              "contents": "EXTERNAL_INPUT['msg']",
              "lock_key": "EXTERNAL_INPUT['secret']",
              "unlock_with": "EXTERNAL_INPUT['secret']",
              "ciphertext": ""
            }
          }
        }
      """
    When I lock the external input in a vault using a symmetric vault key
    Then I can recover the input message using the same key
