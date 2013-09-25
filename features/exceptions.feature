Feature: Vault Tree Exceptions

Scenario: Empty Vault
  Given the broken contract
  When I attempt to open an empty vault
  Then an EmptyVault exception is raised

Scenario: Attempted Fill with Master Password 
  Given the broken contract
  When I attempt fill a vault with my Master Password  
  Then a FillAttemptMasterPassword exception is raised

Scenario: Missing External Data
  Given the broken contract
  When I attempt fill a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Missing Passphrase
  Given a valid blank contract
  When I attempt fill a vault without providing a master passphrase 
  Then a MissingPassphrase exception is raised

Scenario: Unsupported Keyword
  Given the broken contract
  When I attempt fill a vault with an unsupported Keyword
  Then an UnsupportedKeyword exception is raised

Scenario: Vault Does Not Exists
  Given the broken contract
  When I attempt to open a vault that does not exists
  Then a VaultDoesNotExist exception is raised
