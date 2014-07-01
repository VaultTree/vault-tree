[![Code Climate](https://codeclimate.com/github/VaultTree/vault-tree.png)](https://codeclimate.com/github/VaultTree/vault-tree)

## Vault Tree

_The Self Enforcing Contract_

Vault Tree helps you build crypto-based business logic into your application.

Before you begin make sure you checkout the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://vaulttree.gitub.io

### Install

As a prerequisite, get [libsodium] version (>= 0.4.3) on you machine. This is the underlying cryptographic library that Vault Tree depends on.

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

### Usage

The [Documentation] is filled with examples of how to execute Vault Tree contracts.

Also, a great way to get going is to simply run the tests:

* clone the repo
* bundle your dependencies
* run `rake`

You should see a full suite of green tests that will give you plenty of living
examples of how to use Vault Tree in your own application.

[Documentation]: https://www.relishapp.com/vault-tree/vault-tree/docs
