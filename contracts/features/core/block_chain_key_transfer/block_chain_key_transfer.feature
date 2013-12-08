Feature: Block Chain Key Transfer

  This contract introduces the idea of a Bitcoin key transfer.

  Goal:
    * Two parties wish to transfer the BTC signing key associated with a particular wallet address
    * To effect this transfer they want to use only a Vault Tree JSON files and the BTC Block Chain
    * The transfering party wants to maintain control over the precise moment the signing key is
      released to the receiving party.

  Ideas:
    * The sending party can use a Block Chain wallet address as the locking key to a symmetric vault.
    * After generating a hidden wallet address, the sender can use the address to lock the BTC signing
      key in the vault.
    * By spending Bitcoins from an origin wallet address (that is know the receiver) to the hidden
      destination wallet address, the sending party is able to Reveal the encryption key needed to
      unlock the symmetric vault.

  Notes:
    * This transfer could prove useful as a step in a more sophisticated contract.
    * Here we are transfering a BTC Signing Key. This approach could work to transfer any
      type of private information.
    * Transfering Signed but Unbroadcasted transactions with this mechanism could open up
      many new possibilities.

Scenario: SENDER Transfers a BTC Signing Key to the RECEIVER

  Given the SENDER has the blank contract template
  And the SENDER chooses an origin address and a concealed destination address
  And he locks away the secret BTC signing key
  When the SENDER transfers the contract to the RECEIVER
  Then the RECEIVER can access the origin wallet address
  When the SENDER reveals the hidden wallet address by transfering bitcoins from the origin address
  Then the RECEIVER can unlock the vault to recover the transfered signing key
