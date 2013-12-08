Feature: Secret Sharing

Scenario: Lock Away Key Shares With Generated Shamir Key
  Given I have a blank secret sharing contract
  And I create a new message
  When I attempt to lock the message with a generated shamir key
  Then key shares are created and locked away in their cooresponding vaults

Scenario: Lock with Generated Key. Unlock with Assembled Shamir Key
  Given I have a blank secret sharing contract
  And I create a new message
  When I attempt to lock the message with a generated shamir key
  Then key shares are created and locked away in their cooresponding vaults
  When I attempt to unlock the message with the assembled shamir key
  Then I successfully gather the locked shares and unlock the message
