Feature: Asymmetric Vaults

  Goals:
    * Illustrate the use of an Asymmetric Vault
    * Understand the SHARED_KEY reserved word
    * Illustrate an implementation of Public Key Encryption with Mutual Authentication
      via the ECDH algorithm

  Ideas:
    * Notice in the contract that the Locking SHARED_KEY is formed with
      a private key, and the public key of the reciprocal party
    * The cooresponding Unlocking SHARED_KEY is built and authenticated with a private
      key and the reciprocal public key

Scenario: Bob Locks and Alice Unlocks with a Shared Key
  Given Alice has the blank asymmetric vault contract
  When she locks all of her public and private keys
  And she sends the contract to Bob over the internet
  Then Bob can access of her public keys but not her private keys
  When Bob locks his public and private keys
  And He fills and locks the vault containing the message using a SHARED_KEY
  And he sends the contract back to Alice over the internet
  Then Alice can unlock the message with a SHARED_KEY
