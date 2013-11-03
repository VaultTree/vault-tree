Feature: Core Functionality

Scenario: Close And Open With Master Password
  Given I have a blank reference contract
  When I lock a message in a vault with my Master Password
  Then I can recover the message with my Master Password

Scenario: Close And Open With Random Key
  Given I have a blank reference contract
  When I lock away a random vault key
  And I use the random key to lock a message
  Then I can recover the message with the Random Key

Scenario: Transfer Key Via Unlocked Vault
  Given I have a blank reference contract
  When I lock away a random vault key
  And I use the random key to lock a message
  And I put this random key in an unlocked vault
  Then another user can recover the message with the Unlocked Random Key

Scenario: Asymmetric Vault
  Given I have a blank reference contract
  And I have access to the another user's unlocked public key
  And I lock a simple message with a shared key
  When I transfer the contract to the other user
  Then they can create a shared key and unlock the message

Scenario: Example - Alice and Bob Execute a One Two Three Contract
  Given Alice has the blank contract
  When she locks all of her attributes
  And she sends the contract to Bob  
  Then Bob can access her public attributes
  When Bob locks his attributes
  And He fills and locks each of the three vaults
  Then Alice can execute the contract to recover the final message

Scenario: Example - A Simple Block Chain Key Transfer
  Given the SENDER has the blank BTC Key Transfer template
  And the SENDER chooses an origin wallet address and concealed destination address
  And he locks away the secret BTC signing key
  When the SENDER transfers the Vault-Tree contract to the RECEIVER
  Then the RECEIVER can access the origin wallet address
  When the SENDER reveals the hidden wallet address by Blockchain payment from the origin address
  Then the RECEIVER can unlock the vault to recover the transfered signing key
