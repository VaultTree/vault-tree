Feature: CLI vault-tree data [list | add | rm | show] 

  Scenario: vault-tree data [list] (No Data)
    Given an empty settings file
    And a file named "simple_data.json" with:
      """
      TEST DATA
      """
    When I run `vault-tree data list`
    Then the stdout should contain "No Data Files Registered"

  Scenario: vault-tree data [add]
    Given an empty settings file
    And a file named "simple_data.json" with:
      """
      TEST DATA
      """
    When I run `vault-tree data add simple_data '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/simple_data.json'`
    And I run `vault-tree data list`
    Then the stdout should contain "simple_data"

  Scenario: vault-tree data [show] (data)
    Given an empty settings file
    And a file named "simple_data.json" with:
      """
      TEST DATA
      """
    When I run `vault-tree data add simple_data '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/simple_data.json'`
    And I run `vault-tree data show simple_data`
    Then the stdout should contain "TEST DATA"

  Scenario: vault-tree data [rm]
    Given an empty settings file
    And a file named "simple_data.json" with:
      """
      TEST DATA
      """
    When I run `vault-tree data add simple_data '/Users/abashelor/projects/vault-tree/vault-tree/spec/support/cli/files/simple_data.json'`
    And I run `vault-tree data rm simple_data`
    And I run `vault-tree data list`
    Then the stdout should contain "No Data Files Registered"
