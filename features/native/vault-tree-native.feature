Feature: Vault Tree Native Setup

  Goals:
    * Verify the basic functionality of Vault Tree Native

  Scenario: Print to STDOUT
    Given a proper mruby setup
    When I run `vault-tree-native`
    Then the stdout should contain "Running Vault Tree Native"
