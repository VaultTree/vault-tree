Feature: Bob prepares the contract and sends to Alice

Scenario: Bob Fills, Locks, and Signs (FLS) each Vault
  Given Bob has the blank contract
  And he provides and signs his public keys
  When Bob FLS the third vault
  And Bob FLS the second vault
  And Bob FLS the first vault
  Then each vault is properly locked and signed

Scenario: Bob Signs and Sends the contract to Alice
  Given Bob FLS each contract Vault 
  When Bob Affirms, Signs, and Sends the contract to Alice
  Then Alice has and is ready to enforce the contract
