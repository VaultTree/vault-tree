Feature: One-Two-Three Contract

  Goal:
    * Used to demonstrate and test basic Vault Tree functionality
    * It nicely illustrates how vault keys can be arranged to enforce the terms of a contract 
    * If you are new to the Vault Tree Library it may be helpful to study the details of this contract
      to gain a better understanding of the core concepts.

  Ideas:
    * Bob sets up a simple Scavenger Hunt for Alice
    * He locks a Congratulations Message in the final vault
    * In order to get to the final message Alice needs to unlock the preceeding vaults with the
      appropriate keys

Scenario: Alice and Bob Execute the One Two Three Contract
  Given Alice has the blank contract
  When she locks all of her attributes
  And she sends the contract to Bob
  Then Bob can access all of her public attributes
  When Bob locks his attributes
  And He fills and locks each of the three main vaults
  Then Alice can execute the contract to recover the final message
