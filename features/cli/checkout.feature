Feature: CLI Checkout

  Scenario: vault-tree checkout (contract)
    Given an empty settings file
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
    And I run `vault-tree contract add second_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/second_contract.json'`
    And I run `vault-tree checkout first_contract`
    Then the active contract is "first_contract"
    When I run `vault-tree checkout second_contract`
    Then the active contract is "second_contract"
