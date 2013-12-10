Feature: Vault Tree Exceptions

Scenario: Empty Vault
  Given the broken contract
  When I attempt to open an empty vault
  Then an EmptyVault exception is raised

Scenario: Attempted Fill with Master Password 
  Given the broken contract
  When I attempt fill a vault with my Master Password  
  Then a FillAttemptMasterPassword exception is raised

Scenario: Missing External Data On Vault Fill
  Given the broken contract
  When I attempt fill a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Missing External Data On Lock
  Given the broken contract
  When I attempt lock a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Missing External Data On Unlock
  Given the broken contract
  When I attempt unlock a vault with External Data that does not exists
  Then a MissingExternalData exception is raised

Scenario: Unsupported Keyword
  Given the broken contract
  When I attempt fill a vault with an unsupported Keyword
  Then an UnsupportedKeyword exception is raised

Scenario: Vault Does Not Exists on Retrieval
  Given the broken contract
  When I attempt to open a vault that does not exists
  Then a VaultDoesNotExist exception is raised

Scenario: Vault Does Not Exists on Closing
  Given the broken contract
  When I attempt to close a vault that does not exists
  Then a VaultDoesNotExist exception is raised

Scenario: Missing Partner Decryption Key
  Given the broken contract
  When I attempt to fill with an encryption key without first establishing the decryption key
  Then a MissingPartnerDecryptionKey exception is raised

Scenario: Failed Symmetric Unlock Attempt
  Given the broken contract
  When I lock a vault with External Data and attempt to unlock with the wrong External Data
  Then a FailedUnlockingAttempt exception is raised

Scenario: Failed Asymmetric Unlock Attempt
  Given the broken contract
  When I lock a vault with as shared key and attempt to unlock with the wrong decryption key
  Then a FailedUnlockingAttempt exception is raised

Scenario: Lock or Unlock Attempt with Nil key
  Given the broken contract
  When I attempt to lock with a nil key
  Then a NilKey exception is raised
  When I attempt to unlock with a nil key
  Then a NilKey exception is raised
