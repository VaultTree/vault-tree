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
