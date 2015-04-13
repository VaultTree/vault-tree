Feature: Vault Tree Exceptions

  The library trys to anticipate common usage errors. A custom error with a helpful message should be raised if there is a problem with you contract.

  If you do run across an unexpected ruby runtime error, please file a Github issue. I want to make the experience of executing and debugging your own contracts as painless as possible.

  Thanks!

Scenario: Unsupported Keyword
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "unsupported_keyword":{
            "fill_with": "UNSUPPORTED_KEYWORD",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt fill a vault with an unsupported Keyword
  Then an exception is raised

Scenario: Vault Does Not Exists on Retrieval
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_vault":{
            "fill_with": "RANDOM_KEY",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to open a vault that does not exists
  Then an exception is raised

Scenario: Vault Does Not Exists on Closing
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_vault":{
            "fill_with": "RANDOM_KEY",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to close a vault that does not exists
  Then an exception is raised

Scenario: Failed Symmetric Unlock Attempt
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "some_random_vault":{
            "fill_with": "RANDOM_KEY",
            "lock_with": "EXTERNAL_INPUT['right_secret']",
            "unlock_with": "EXTERNAL_INPUT['wrong_secret']",
            "contents": ""
          }
        }
      }
    """
  When I lock a vault with External Input and attempt to unlock with the wrong External Input
  Then an exception is raised

Scenario: Missing External Input On Lock
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "missing_external_input_vault":{
            "fill_with": "EXTERNAL_INPUT['empty_value']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt lock a vault with External Input that does not exists
  Then an exception is raised
