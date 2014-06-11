Feature: Split Key

  ```javascript
  SPLIT_KEY['id_1','id_2','id_3']
  ```
  Split Key is a simple form of secret sharing.

Scenario: Close And Open With Split Key
  Given the blank contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "a_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_KEY['a_secret']",
            "unlock_with": "EXTERNAL_KEY['a_secret']",
            "contents": ""
          },

          "b_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_KEY['b_secret']",
            "unlock_with": "EXTERNAL_KEY['b_secret']",
            "contents": ""
          },

          "c_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_KEY['c_secret']",
            "unlock_with": "EXTERNAL_KEY['c_secret']",
            "contents": ""
          },

          "abc_joint_consent_key":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "SPLIT_KEY['a_consent_key','b_consent_key','c_consent_key']",
            "unlock_with": "SPLIT_KEY['a_consent_key','b_consent_key','c_consent_key']",
            "contents": ""
          },

          "abc_consent_message":{
            "fill_with": "EXTERNAL_INPUT['consent_message']",
            "lock_with": "KEY['abc_joint_consent_key']",
            "unlock_with": "KEY['abc_joint_consent_key']",
            "contents": ""
          }
        }
      }
    """
  And Consent keys for parties A, B, and C
  When I lock a away the consent keys
  And I lock a message in a vault using a split key
  Then I can recover the message if each party gives consent
  And I cannot recover the message if one party fails to give consent
