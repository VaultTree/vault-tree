## Vault Tree

_The Self Enforcing Contract_

Vault Tree is a collection of tools for building and executing distributed
cryptographic contracts.

Before you begin make sure you checkout the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://www.vault-tree.org

### Welcome!

The Vault Tree Project consists of:

* A JSON based DSL for building Distributed Crytographic Contracts
* A a Ruby library to execute these contracts
* A Github [Contracts Repository] that acts as a focal point of collaboration
for developers writing and testing interesting crytographic contracts

[Contracts Repository]: https://github.com/VaultTree/contracts

### Install

As a prerequisite get [libsodium] on you machine.

This is the underlying cryptographic library that Vault Tree depends on.

If you are on _OSX_ there is a [brew] package available.

```
brew install libsodium
```

If you are a Ruby developer, you know the drill from here:

```
gem install vault-tree
```
and then 

```
require 'vault-tree'
```

somewhere before you use it.

[brew]: http://brew.sh/
[libsodium]: https://github.com/jedisct1/libsodium

### Is it prduction ready?

Absolutely not. We have a long way to go.

Here are some of the big issues that I could use your help on as we move to version 1.0:

* This is a crypto application so vulnerabilities need to be identified and corrected. We need more eyes in this area.
* We we need to figure out if the supported keywords are sufficient to implement basic secure computation schemes.
  - For example, Digital Signatures and HMACs are not implemented but could be.
  - Should they be implemented? What is the use case? Ect. We need to have these conversations.

### Install Roadmap

I'm commited to making this install painless for everyone. Here is what is coming in the near future.

* Pre-Packaged [Vagrant] box that is available for download
* Clear install instructions or an `apt-get` package of [libsodium] for Debian based systems

Bere with me, I just haven't found the time yet.

[Vagrant]: http://www.vagrantup.com/
[libsodium]: https://github.com/jedisct1/libsodium
