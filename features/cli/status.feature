Feature: CLI Status 

  Scenario: vault-tree status
    Given the default settings file
    When I run `vault-tree status`
    Then the stdout should contain "Contract Status"
    And the exit status should be 0
