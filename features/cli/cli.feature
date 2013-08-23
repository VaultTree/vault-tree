Feature: CLI Basic Commands

  The command line interface helps to organize user input and
  passes it to the iterpreter.

Scenario: vault-tree
  Given the default settings file
  When I run `vault-tree`
  Then the stdout should contain "The Self Enforcing Contract"
  And the exit status should be 0
