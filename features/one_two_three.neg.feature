Feature: Bob prepares the contract and sends to Alice

Scenario: Bob Fills, Locks, and Signs (FLS) each Vault
  Given "Bob" has the blank contract
  When "Bob" FLS Vault '[1,2,3]'
  And "Bob" FLS Vault '[1,2]'
  And "Bob" FLS Vault '[1]'
  Then each vault is properly locked and signed

Scenario: Bob Signs and Sends the contract to Alice
  Given "Bob" FLS each contract Vault 
  When "Bob" Affirms, Signs, and Sends the contract to "Alice"
  Then "Alice" has and is ready to enforce the contract
