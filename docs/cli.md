# Command Line Interface

Vault Tree provides a CLI so developers can execute contracts and experiment
with the Interpreter.

## Getting Started

To view available commands issue:
  `$: vault-tree`

or the convenient alias:
  `$: vt`

### Specify the Contract

All vault tree CLI commands apply to a specific contract. The first global
argument is always a file path the contract. For example:

  `$: vault-tree /path/to/contract.json close some_vault_name`

### Contract Status

To get a helpful summary of a contract file, along with available actions issue:

  `$: vault-tree /path/to/contract.json`

### Closing Vaults 

To close a vault

  `$: vault-tree /path/to/contract.json close vault_name`

Keep in mind that in addition to closing the specified vault `vault_name`, the
interpreter will attempt to close all fill ancestors, and lock ancestors. 

### Opening Vaults

To retrieve the contents of a specific vault. Issue:

  `$: vault-tree /path/to/contract.json open vault_name`

If you attempt to pass external data to an open command the CLI will raise an
exception.

### External Data

The Vault Tree interpreter does not interact with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that it has been given all necessary external data. In short, you can expect the
Vault Tree interpreter to stick to the following rules:

* External Data is relevent only when *closing* a vault. When a vault is being opened,
the interpreter expects that all the necessary data has already been locked
somewhere in the contract.
* External Data must be a String

