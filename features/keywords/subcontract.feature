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
              "fill_with": "SUBCONTRACT['first_vault','second_vault']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            },
            "first_vault":{
              "fill_with": "RANDOM_NUMBER",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            },
            "second_vault":{
              "fill_with": "RANDOM_NUMBER",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            }
          }
        }
      """
    When we lock the first and second vault
    And we lock the subcontract vault
    Then a new contract is and locked into the subcontract vault
    When we open the subcontract vault
    Then we can recover the newly written subcontract
