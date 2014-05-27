[![Code Climate](https://codeclimate.com/github/VaultTree/vault-tree.png)](https://codeclimate.com/github/VaultTree/vault-tree)

## Vault Tree

_The Self Enforcing Bitcoin Contract_

Vault Tree helps developers build distributed applications on top of the Bitcoin Blockchain.

Before you begin make sure you checkout the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://vault-tree.org

### Welcome!

The Vault Tree Project consists of:

* A JSON based DSL for building Distributed Crytographic Contracts
* A a Ruby library to execute these contracts
* A focal point of collaboration for developers writing and testing interesting crytographic contracts

### Install

As a prerequisite get [libsodium] (>= 0.4.3) on you machine. This is the underlying cryptographic library that Vault Tree depends on.

[libsodium]: https://github.com/jedisct1/libsodium

* If you are on _OSX_ there is a [brew] package available. So just:

  ```
  brew install libsodium
  ```

[brew]: http://brew.sh/

* If you're on a Debian based system, there is no _apt-get_ package that I know of, but there
  are some helpful install scripts on the web.

Now that you have libsodium, if you're a Ruby developer you know the drill from here:

```
gem install vault-tree
```

and then

```
require 'vault-tree'
```

somewhere before you use it.
