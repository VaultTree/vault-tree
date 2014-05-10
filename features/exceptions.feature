Feature: Vault Tree Exceptions

  The library trys to anticipate common usage errors. A
  custom error with a helpful message should be raised if there
  is a problem with you contract.

  If you do run across an unexpected ruby runtime error, please
  file a Github issue. I want to make the experience of executing
  and debugging your own contracts as painless as possible.

  Thanks!

Scenario: Empty Vault
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_vault":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to open an empty vault
  Then an EmptyVault exception is raised

Scenario: Missing External Data On Vault Fill
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "missing_external_data_vault":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt fill a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Missing External Data On Lock
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "missing_external_data_vault":{
            "fill_with": "EXTERNAL_DATA",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt lock a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Missing External Data On Unlock
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "missing_external_data_vault":{
            "description": "The external data is not provided in the initialzer. See the step definitions in this case.",
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "RANDOM_NUMBER",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          }
        }
      }
    """
  When I lock the data away
  And I attempt to unlock a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

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
  Then an UnsupportedKeyword exception is raised

Scenario: Vault Does Not Exists on Retrieval
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_vault":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to open a vault that does not exists
  Then a VaultDoesNotExist exception is raised

Scenario: Vault Does Not Exists on Closing
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_vault":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to close a vault that does not exists
  Then a VaultDoesNotExist exception is raised

Scenario: Missing Partner Decryption Key
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {

          "empty_decryption_key":{
            "description": "Leave this empty.",
            "fill_with": "DECRYPTION_KEY",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          },

          "orphaned_public_key":{
            "description": "Attempt to establish a public key with first building a decryption key",
            "fill_with": "PUBLIC_ENCRYPTION_KEY['empty_decryption_key']",
            "lock_with": "UNLOCKED",
            "unlock_with": "UNLOCKED",
            "contents": ""
          }
        }
      }
    """
  When I attempt to fill with an encryption key without first establishing the decryption key
  Then a MissingPartnerDecryptionKey exception is raised

Scenario: Failed Symmetric Unlock Attempt
  Given this broken contract:
    """javascript
      {
        "header": {},
        "vaults": {
          "missing_external_data_vault":{
            "fill_with": "RANDOM_NUMBER",
            "lock_with": "EXTERNAL_DATA",
            "unlock_with": "EXTERNAL_DATA",
            "contents": ""
          }
        }
      }
    """
  When I lock a vault with External Data and attempt to unlock with the wrong External Data
  Then a FailedUnlockAttempt exception is raised

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
  Then an InvalidExternalInput exception is raised
