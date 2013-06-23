Feature: One-Two-Three Contract Negotiation
  This contract represents the simplest contract
  that can test the full Vault Tree stack.
  
  There are Two Participants: Alice and Bob
  * Alice provides her public keys and sends the contract to Bob
  * Bob provides keys and procedes to fill, lock and sign each vault.
  * He fills the vaults with the following:
    - Vault Three: A simple congratulations message.
    - Vault Two: The key for Vault Three
    - Vault One: The key for Vault Two
  * Vault One is locked with Alice's Public Encryption Key

Scenario: Alice provides keys and sends the contract to Bob
  Given Alice has the blank contract
  When she writes and signs her public attributes
  And she sends the contract to Bob  
  Then Bob can validate her public attributes

Scenario: Bob Fills, Locks, and Signs (FLS) each Vault
  Given Bob has the blank contract
  And he writes and signs his public attributes
  When Bob FLS the third vault
  And Bob FLS the second vault
  And Bob FLS the first vault
  Then each vault is properly locked and signed

Scenario: Bob Signs and Sends the contract to Alice
  Given Bob FLS each contract Vault 
  When Bob Affirms, Signs, and Sends the contract to Alice
  Then Alice has and is ready to enforce the contract
