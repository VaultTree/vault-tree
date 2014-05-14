Feature: Assembled Shamir Key

Scenario: Lock with Generated Key. Unlock with Assembled Shamir Key
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "s_1":{
            "fill_with": "SHAMIR_SHARE['share_collection','1']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "s_2":{
            "fill_with": "SHAMIR_SHARE['share_collection','2']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "s_3":{
            "fill_with": "SHAMIR_SHARE['share_collection','3']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "s_4":{
            "fill_with": "SHAMIR_SHARE['share_collection','4']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "s_5":{
            "fill_with": "SHAMIR_SHARE['share_collection','5']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "share_collection":{
            "fill_with": "SHAMIR_KEY_SHARES['5','3']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },
          "message":{
            "fill_with": "EXTERNAL_INPUT['msg']",
            "lock_with": "ASSEMBLED_SHAMIR_KEY['s_1','s_2','s_3','s_4','s_5']",
            "unlock_with": "ASSEMBLED_SHAMIR_KEY['s_1','s_2','s_3','s_4','s_5']",
            "contents": ""
          }
        }
      }
    """
  When I lock away the shamir key share collection
  And I close the key shares in their respective vaults
  Then I can lock away a message with the key assembled from the shares
  And if all the shares are available I can unlock the message
