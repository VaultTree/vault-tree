Feature: One Two Three Round Trip
  Export, Import, and Generation of simple One Two Three Contract

  Scenario: Export Contract
    Given we set up the One Two Three Contract
    When we export this contract
    Then this contract is written to the proper file
  Scenario: Export then Import Contract
  Scenario: Export Template
  Scenario: Export then Import Template
  Scenario: Import Template, Generate Contract, Export Contract
  Scenario: Import Contract, Enforce Contract, Export Contract Log
