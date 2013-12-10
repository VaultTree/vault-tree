Feature: Split Key

  ```javascript
  SPLIT_KEY['id_1','id_2','id_3']
  ```
  Split Key is a simple for of secret sharing. 

Scenario: Close And Open With Split Key
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "a_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          },

          "b_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          },

          "c_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          },

          "abc_joint_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "SPLIT_KEY['a_consent_key','b_consent_key','c_consent_key']",
            "unlock_with": "SPLIT_KEY['a_consent_key','b_consent_key','c_consent_key']",
            "contents": ""
          },

          "abc_consent_message":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "CONTENTS['abc_joint_consent_key']",
            "unlock_with": "CONTENTS['abc_joint_consent_key']",
            "contents": ""
          }
        }
      }
    """
  And Consent keys for parties A, B, and C
  When I lock a message in a vault using a split key
  Then I can recover the message if each party gives consent
  And I cannot recover the message if one party fails to give consent
