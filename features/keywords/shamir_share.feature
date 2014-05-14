Feature: Shamir Share

  Scenario: Lock Secret Shares in thier respective vaults
    Given the blank contract:
      """javascript
        {
          "header": {},
          "vaults": {

            "share_collection":{
              "fill_with": "SHAMIR_KEY_SHARES['3','2']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            },
            "share_1":{
              "fill_with": "SHAMIR_SHARE['share_collection','1']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            },
            "share_2":{
              "fill_with": "SHAMIR_SHARE['share_collection','2']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            },
            "share_3":{
              "fill_with": "SHAMIR_SHARE['share_collection','3']",
              "lock_with": "UNLOCKED",
              "unlock_with": "UNLOCKED",
              "contents": ""
            }
          }
        }
      """
    When I lock away the shamir key share collection
    Then a random key is generated and split with the shamir secret sharing algorithm
    When I fill an individual vault with the SECRET_SHARES keyword
    Then the library takes the approprate share from the collection vault and locks it away
