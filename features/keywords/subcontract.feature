Feature: Subcontract

  ```
    SUBCONTRACT
  ```

  is used to fill a vault with another Vault Tree Contract.

  Scenario: Fill, Lock and Open a Vault containing a subcontract
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {

            "subcontract_vault":{
              "contents": "SUBCONTRACT['first_vault','second_vault']",
              "lock_key": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "ciphertext": ""
            },
            "first_vault":{
              "contents": "RANDOM_KEY",
              "lock_key": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "ciphertext": ""
            },
            "second_vault":{
              "contents": "RANDOM_KEY",
              "lock_key": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "ciphertext": ""
            }
          }
        }
      """
    When we lock the first and second vault
    And we lock the subcontract vault
    Then a new contract is and locked into the subcontract vault
    When we open the subcontract vault
    Then we can recover the newly written subcontract
