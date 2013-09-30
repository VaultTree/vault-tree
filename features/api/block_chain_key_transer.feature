Feature: Block Chain Key Transfer

Scenario: SENDER Transfers a BTC Signing Key to the RECEIVER

  Given the SENDER has the blank BTC Key Transfer template
  And the SENDER chooses an origin wallet address and concealed destination address
  And he locks away the secret BTC signing key
  When the SENDER transfers the Vault-Tree contract to the RECEIVER
  Then the RECEIVER can access the origin wallet address
  When the SENDER reveals the hidden wallet address by Blockchain payment from the origin address
  Then the RECEIVER can unlock the vault to recover the transfered signing key
