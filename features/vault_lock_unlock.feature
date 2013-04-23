Feature: Lock and Unlock a Symmetric Vault

  Scenario: Create and Fill Symmetric Vault
    Given we have some objects
    And we create a symmetric vault and put the objects inside
    When we ask for the contents
    Then we get the contents back

  Scenario: Lock the Vault
    Given we have some objects
    And we create a symmetric vault and put the objects inside
    When we lock the vault
    And we ask for the contents
    Then we get nothing back

  Scenario: Lock and Unlock the Vault
    Given we have some objects
    And we create a symmetric vault and put the objects inside
    When we lock the vault
    And we unlock the vault
    Then we get the clear text contents back

  Scenario: Create, Fill, Serialize and Deserialize
    Given we have some objects
    And we create a symmetric vault and put the objects inside
    When we serialize then deserialize the vault
    And we ask for the contents
    Then we get the contents back

  Scenario: Lock, Serialize, and Deserialize
    Given we have some objects
    And lock the objects in a symetric vault
    When we serialize then deserialize the vault
    And we ask for the contents
    Then we get nothing back

  Scenario: Lock, Serialize, Deserialize, and Unlock
    Given we have some objects
    And we create a symmetric vault and put the objects inside
    When we lock the vault
    And we serialize then deserialize the vault
    And we unlock the vault
    Then we get the clear text contents back
