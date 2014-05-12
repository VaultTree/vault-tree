Feature: Shamir Key Shares

  ```
    SHAMIR_KEY_SHARES
  ```

  is used to fill a vault with a collection of secret shares
  that have been obtained by breaking up a random secret key
  with the Shamir Secret Sharing Algorithm.

  Scenario: Lock away a collection of shamir key shares
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {

            "share_collection":{
              "fill_with": "SHAMIR_KEY_SHARES['5','3']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            }
          }
        }
      """
    When I lock away the shamir key share collection
    Then a random key is generated and split with the shamir secret sharing algorithm
    And I can open the vault to recover the JSON representation of the secret shares
