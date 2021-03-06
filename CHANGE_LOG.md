## 0.16.0 - CLI Stabilization
  * Fix Basic use cases at the commandline
  * Enhance README and fix problems with the Quick Start Guide Description
  * Generate Random key functionality at the command line

## 0.15.0 - Project Wide Clean Up
  * README cleanup with new quick start guide
  * Trim down Dockerfile and use Phusion Passenger Ruby image
  * Building and testing from a simplified Dockerfile
  * Add some specs around stringify_keys method
  * Some small refactors accross the library
  * Some ideas for CLI Error handling

## 0.14.0 - Integration Test Rewrite
  * Remove existing cucumber features
  * Transfer verbiage From existing cucumber feature to minitest comments
  * Rewrite the following specs to use vt commandline parser:
    - One Two Three Vaults
    - Nested Vault Collection
    - Asym Vault Collection
    - BTC Blockchain Key Transfer

## 0.13.0 - Core Implementation Refactoring
  * JSON Based Collection Structure and Schema
  * Introduce CollectionBuilder Class
  * Introduce Expression Class
  * Introduce VaultCollection Class
  * Rework Vault class for functional open and close

## 0.12.3

Unlock With to Unlock Key
* In all contracts the key "unlock_with" is replaced with "unlock_key"
* This paves the way for future changes to the contract structure

## 0.12.2

Lock With to Lock Key
* In all contracts the key "lock_with" is replaced with "lock_key"
* This paves the way for future changes to the contract structure

## 0.12.1

Fill With to Contents
* In all contracts the key "fill_with" is replaced with "contents"
* This paves the way for future changes to the contract structure

## 0.12.0

Contents to Ciphertext
* In all contracts the key "contents" is replaced with "ciphertext"
* This paves the way for future changes to the contract structure

## 0.11.1

JSON Schema Experimentation
Considering changing the Vault Tree DSL this is
some exploration work with JSON Schema

* Bring down the JSON Schema validation gem
* Minitest example to spike out new JSON contracts
* No changes to existing implementation

## 0.11.0
Random Byte Generation
* Rename RANDOM_NUMBER to RANDOM_KEY
* Add a secure hash to the random key
  generation process.

## 0.10.4
Enhance Notification Messages
* Try to make notifications more helpful

Refactor Custom Exceptions
* Vault Tree no longer raises custom exceptions
* Instead, the library will alway raise the lower level error
* When a known exception is caught. Vault Tree with print a helpful
  notification message to Standard Out.

## 0.10.3
Docker
* Using Docker for testing

## 0.10.2
Eliminate Rspec

* Go to mintest for unit specs
* Switch to test unit style assertions in step definitions
* Run minitests from rake

## 0.10.1
Remove References to Digital Signatures

* Clean up some old references to signature functionality
* I do not intend to bring message signing functionality to Vault Tree.
  (Of course, Nacl performs authenticated encryption under the hood)

Rbnacl supports digital signatures. Over time have toyed with the idea of
bringing this functionality into Vault Tree.

For now, signing will be left out and the library will focus on locking and
unlocking strings. The locked strings may well be signed messages or
verification/signing keys, but these operations should be handled by an
external tool.

## 0.10.0
Removing Secret Sharing and Split Key Functionality
* Not clear that this functionality should be a core part of the library
* If included, we will need to rely on an audited third party gem
* It would require additional crypto operations that are ouside of the scope
  of Nacl and Rbnacl.
* Git history will maintain the first attempt at this feature so if there
  are new proposals to reinstate this code in the future, we should be able
  to organize a pull request without much effort.

## 0.8.0
* Rbnacl Version 3.1.1
* Rbnacl/libsodium
  - Build Crypto library on gem install

## 0.6.0

* Return JSON from close_vault method
- now open_vault and close_vault return as string
* Update tests to support new public interface

## 0.3.17

* Remove support for EXTERNAL_DATA Keyword
* Use EXTERNAL_INPUT Insead

## 0.3.16

* Remove support for GENERATED_SHAMIR_KEY Keyword

## 0.3.7

* Add Better Exception Messaging
* Verbose Messaging when Vault Tree Exceptions are thrown
* Log the Message to STDOUT
* Pattern for implementing future custom exceptions

## 0.3.5

* Remove support for MASTER_PASSPHRASE Keyword.
* MASTER_PASSPHRASE has been removed from example contracts.

## 0.3.4

* Bug Fix in Exception Handling
* Eliminate File missing error when execption is thrown

## 0.3.3

* Update to RbNaCl 2.0.
* Major changes to crypto lib interface
* Now Require Libsodium >= 0.4.3

## 0.2.3

* Reorganize features dir to work with Relish
* Modify some Cucumber features to explicitly take a hard coded contract

## 0.2.1

* First pass implementation of GENERATED_SHAMIR_KEY and ASSEMBLED_SHAMIR_KEY
* Using version 0.3 of https://github.com/grempe/secretsharing
