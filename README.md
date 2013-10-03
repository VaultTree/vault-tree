## Vault Tree

__The Self Enforcing Contract__

Vault Tree is a collection of tools for building and executing distributed
cryptographic contracts.

### Welcome

If you are coming to this page from Github and are unfamiliar with Vault Tree,
please take a look at the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://www.vault-tree.org

## Install

As a prerequisite you will need to get [libsodium] on you machine.

This is the underlying cryptographic library that Vault Tree uses.

If you are on OS X there is a brew package available.

```
brew install libsodium
```

If you are a Ruby developer, you know the drill from here

```
gem install vaelt-tree
```

somewhere before you use it:

```
require 'vault-tree'
```

### Install Roadmap

I'm commited to making this install painless for everyone. Here is what is coming in the near future.

* Complete Vault Tree `brew` Package for OS X devs
* Complete Vault Tree `apt-get` Package for Debian based systems
* Pre-Packaged [Vagrant] box that is available for download

Bear with me, I just haven't found the time yet.

[Vagrant]: http://www.vagrantup.com/

## Usage

You can use Vault Tree in two ways:
* As a Ruby library to execute Vault Tree contracts
