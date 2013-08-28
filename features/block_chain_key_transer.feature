Feature: Block Chain Key Transfer

  A simple key transfer sheme utilizing a revealed BTC Wallet Address
  This can be used as step within the execution of a larger contract.

  Key Concepts:
  * SENDER wishes to transfer a BTC signing key to RECEIVER
  * An origin wallet address is established by the SENDER
  and made known via the contract to the RECEIVER
  * A BTC Signing key is locked in a symmetric vault by the SENDER.
  * The vault key used to lock the signing key is a valid BTC wallet
  address that is concealed by the SENDER.
  * The RECEIVER monitors the known origin wallet address. When a bitcoin
  payment occurs from the origin wallet address to the concealed destination address,
  the revealed address can be used by the RECEIVER to unlock the signing key.

Scenario: Sender Transfers a BTC Signing Key to the Receiver

  Given a SENDER, RECEIVER, and valid Bitcoin addresses and keys
  When the SENDER locks his vaults and transfers the contract to the RECEIVER 
  And signals the concealed wallet address via the Blockchain
  Then the RECEIVER can recover the transfered signing key 
