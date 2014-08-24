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
