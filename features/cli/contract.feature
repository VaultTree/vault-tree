Feature: vault-tree contract [list | add | rm | show]

  Scenario: vault-tree contract [list] (No Contracts)
    Given an empty settings file
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    When I run `vault-tree contract list`
    Then the stdout should contain "No Contracts Registered"

  Scenario: vault-tree contract [add]
    Given an empty settings file
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
    And I run `vault-tree contract list`
    Then the stdout should contain "first_contract"

  Scenario: vault-tree contract [show]
    Given an empty settings file
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
    When I run `vault-tree contract show`
    Then the stdout should contain "TEST CONTENTS"

  Scenario: vault-tree contract [rm]
    Given an empty settings file
    And a file named "first_contract.json" with:
      """
      TEST CONTENTS
      """
    When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
    And I run `vault-tree contract rm first_contract`
    And I run `vault-tree contract list`
    Then the stdout should contain "No Contracts Registered"
