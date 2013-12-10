Feature: Assembled Shamir Key

Scenario: Lock with Generated Key. Unlock with Assembled Shamir Key
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "s_1":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "s_2":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "s_3":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "s_4":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "s_5":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "message":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "GENERATED_SHAMIR_KEY['5','3','s_1','s_2','s_3','s_4','s_5']",
            "unlock_with": "ASSEMBLED_SHAMIR_KEY['s_1','s_2','s_3','s_4','s_5']",
            "contents": ""
          }
        }
      }
    """
  And I create a new message
  When I attempt to lock the message with a generated shamir key
  Then key shares are created and locked away in their cooresponding vaults
  When I attempt to unlock the message with the assembled shamir key
  Then I successfully gather the locked shares and unlock the message
