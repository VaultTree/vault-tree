## Vault Tree

__The Self Enforcing Contract__

Vault Tree is a collection of tools for building and executing distributed
cryptographic contracts.

### Welcome

If you are coming to this page from Github and are unfamiliar with Vault Tree,
please take a look at the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://www.vault-tree.org

## Install

There are two ways to get up and going:

* Use [Vagrant]
* Package and Gem Install with [Brew] and [Bundler]

[Brew]: http://brew.sh/
[Bundler]: http://bundler.io/
[Vagrant]: http://www.vagrantup.com/

#### Vagrant Install

It should be easy for you to get Vault Tree development environment up and running.
If you don't know about Vagrant, you should, it's awesome!

* Follow the [Vagrant] download and install steps
* Clone the Repo and go to it:
```
  git clone git@github.com:VaultTree/vault_tree.git
  cd ~/path/to/vault_tree/
```
* Vagrant Up!
```
  vagrant up
```
This will download and boot the prepackaged Vault Tree virtual machine.

* SSH into the box
```
vagrant ssh
```

[Virtual Box]: https://www.virtualbox.org/wiki/Downloads 
[Vagrant]: http://downloads.vagrantup.com 


### Package Install

You need to first get [libsodium] on you machine. This is distribution of Vault
Tree's underlying cryptographic library.



From here you know the drill.

```
gem install vault_tree
```

or put the [latest version] in your `Gemfile`


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

