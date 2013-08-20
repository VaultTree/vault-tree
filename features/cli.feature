Feature: CLI Basic Commands

  The command line interface organizes user input and
  passes it to the iterpreter.

  Commands:
  * vault-tree
  * vault-tree settings
  * vault-tree status
  * vault-tree contract [list | add | rm | show]
  * vault-tree checkout (contract)
  * vault-tree data [list | add | rm | show]
  * vault-tree vault [open | close]


Scenario: vault-tree
  Given the default settings file
  When I run `vault-tree`
  Then the stdout should contain "The Self Enforcing Contract"
  And the exit status should be 0

Scenario: vault-tree settings
  Given an empty settings file
  When I run `vault-tree settings`
  Then the stdout should contain "EMPTY_SETTINGS_PASSWORD"

Scenario: vault-tree contract [list | add | show]
  Given an empty settings file
  And a file named "first_contract.json" with:
    """
    TEST CONTENTS
    """
  When I run `vault-tree contract list`
  Then the stdout should contain "No Contracts Registered"
  When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
  And I run `vault-tree contract list`
  Then the stdout should contain "first_contract"
  When I run `vault-tree contract show first_contract`
  Then the stdout should contain "TEST CONTENTS"
  When I run `vault-tree contract rm first_contract`
  And I run `vault-tree contract list`
  Then the stdout should contain "No Contracts Registered"

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

Scenario: vault-tree checkout (contract)
  Given an empty settings file
  And a 1000 byte file named "first_contract.json"
  And a 1000 byte file named "second_contract.json"
  When I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/first_contract.json'`
  And I run `vault-tree contract add first_contract '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/second_contract.json'`
  And I run `vault-tree checkout first_contract`
  Then the active contract is "first_contract"
  When I run `vault-tree checkout second_contract`
  Then the active contract is "second_contract"

#Scenario: vault-tree status
  #Given the default settings file
  #When I run `vault-tree status`
  #Then the stdout should contain "Contract Status"
  #And the exit status should be 0
