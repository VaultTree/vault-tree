## Unlocked

The `UNLOCKED` keyword should be used when a vault contains contents that are
accessable to anyone.

## External Data

The Vault Tree interpreter does not interact with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that it has been given all necessary external data. In short, you can expect the
Vault Tree interpreter to stick to the following rules:

* External Data is relevent only when *closing* a vault. When a vault is being opened,
the interpreter expects that all the necessary data has already been locked
somewhere in the contract.
* External Data must be a String

