Feature: One-Two-Three Contract Negotiation

Scenario: Alice and Bob Execute the One Two Three Contract
  Given Alice has the blank contract
  When she locks all of her public attributes
  And she sends the contract to Bob  
  Then Bob can access all of her public attributes
  When Bob locks his public attributes
  And He fills and locks each of the three vaults
  Then Alice can execute the contract to recover the final message
