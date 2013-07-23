Feature: One-Two-Three Contract Negotiation
  This contract represents the simplest contract
  that can test the full Vault Tree stack.
  
  There are Two Participants: Alice and Bob
  * Alice provides her public data and sends the contract to Bob
  * Bob provides keys and procedes to fill and lock, each vault.
  * He fills the vaults with the following:
    - Vault Three: A simple congratulations message.
    - Vault Two: The key for Vault Three
    - Vault One: The key for Vault Two
  * Vault One is locked with Alice's Public Encryption Key

Scenario: Alice and Bob Execute the One Two Three Contract
  Given Alice has the blank contract
  When she locks all of her public attributes
  And she sends the contract to Bob  
  Then Bob can access all of her public attributes
  When Bob locks his public attributes
  And He fills and locks each of the three vaults
  Then Alice can execute the contract to recover the final message
