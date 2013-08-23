Feature: CLI Vault

  Scenario: vault-tree vault close (vault_name) (data)
    Given the default settings file
    And I run `vault-tree contract add simple_test_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/fixtures/simple_test_contract.json'`
    And I run `vault-tree data add simple_data '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/fixtures/simple_data.json'`
    When I run `vault-tree checkout simple_test_contract`
    And I run `vault-tree vault close simple_message simple_data`
    Then the stdout should contain "Contract Status"
    And the exit status should be 0

  Scenario: vault-tree vault open (vault_name)
    Given this is a work in progress
    Given the default settings file
    And the cli test contract and test data
    When I run `vault-tree vault open simple_message`
    Then the stdout should contain "This is a simple message"
    And the exit status should be 0

  Scenario: vault-tree vault close --write (vault_name)
    Given this is a work in progress
    Given the default settings file
    And the cli test contract and test data
    When I run `vault-tree status`
    Then the stdout should contain "Contract Status"
    And the exit status should be 0
