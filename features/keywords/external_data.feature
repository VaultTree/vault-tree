Feature: External Data

The Vault Tree interpreter does not interact directly with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that all necessary external data will be explicitly passed in.

In short, you can expect the interpreter to stick to the following rules:

* External Data is relevent only when **closing** a vault.
* When a vault is being opened, the interpreter expects that all the necessary data has already been locked somewhere in the contract.
* External Data must be a string
