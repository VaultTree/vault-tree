Feature: One Two Three Round Trip
  Export, Import, and Generation of simple One Two Three Contract

  Scenario: Export Contract
    Given we set up the One Two Three Contract
    When we export this contract
    Then the file "contracts/one_two_three.json" should contain "one_two_three"

  Scenario: Export,Import, then Export Again
    Given we set up the One Two Three Contract
    When we export this contract
    Then the file "contracts/one_two_three.json" should contain "one_two_three"
    When we import the one_two_three contract
    And we delete the file
    And we export the one_two_three contract
    Then the file "contracts/one_two_three.json" should contain "one_two_three"

  Scenario: Export Template
  Scenario: Export then Import Template
  Scenario: Import Template, Generate Contract, Export Contract
  Scenario: Import Contract, Enforce Contract, Export Contract Log
