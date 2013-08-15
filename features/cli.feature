Feature: CLI Basic Commands

  The command line interface organizes user input and
  passes it to the iterpreter.

  Commands:
  * vault-tree
  * vault-tree status
  * vault-tree contract [list | add | rm | show]
  * vault-tree checkout (contract)
  * vault-tree data [list | add | rm | show]
  * vault-tree vault [open | close]

Scenario: Settings File
  Given the default settings file
  Then the settings file should exists

Scenario: vault-tree
  Given the default settings file
  When I run `vault-tree`
  Then the stdout should contain "The Self Enforcing Contract"
  And the exit status should be 0

Scenario: vault-tree status
  Given the default settings file
  When I run `vault-tree status`
  Then the stdout should contain "Contract Status"
  And the exit status should be 0
