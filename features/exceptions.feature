Feature: Vault Tree Exceptions

Scenario: Empty Vault
  Given the broken contract
  When I attempt to open an empty vault
  Then an EmptyVault exception is raised

Scenario: Attempted Fill with Master Password 
  Given the broken contract
  When I attempt fill a vault with my Master Password  
  Then a FillAttemptMasterPassword exception is raised

Scenario: Invalid Asymmetric Vault
  Given not yet implemented

Scenario: Malformed JSON
  Given not yet implemented

Scenario: Missing External Data
  Given not yet implemented

Scenario: Missing Password
  Given not yet implemented

Scenario: Unsupported Keyword
  Given not yet implemented

Scenario: Vault Does Not Exists
  Given the broken contract
  When I attempt to open a vault that does not exists
  Then a VaultDoesNotExist exception is raised
