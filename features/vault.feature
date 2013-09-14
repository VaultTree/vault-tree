Feature: CLI Vault

  Background:
    Given the default settings file
    And a blank simple test contract
    And I run `vault-tree contract add simple_test_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/fixtures/simple_test_contract.json'`
    And I run `vault-tree data add simple_data '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/fixtures/simple_data.json'`
    And I compute the contract checksum
    When I run `vault-tree checkout simple_test_contract`


  Scenario: vault-tree vault close (vault_name) (data)
    When I run `vault-tree vault close simple_message simple_data`
    Then the stdout should contain "Contract Status"
    And the exit status should be 0

  Scenario: vault-tree vault close --write (vault_name)
    When I run `vault-tree vault -w close simple_message simple_data`
    Then the stdout should contain "Contract Status"
    And I can see the contract changes have been written to disk
    And the exit status should be 0

  Scenario: vault-tree vault open (vault_name)
    When I run `vault-tree vault close -w simple_message simple_data`
    And I run `vault-tree vault open simple_message`
    Then the stdout should contain "This is a simple message"
    And the exit status should be 0
