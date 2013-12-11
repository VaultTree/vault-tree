## Vault Tree

_The Self Enforcing Contract_

Vault Tree is a collection of tools for building and executing distributed cryptographic contracts.

Before you begin make sure you checkout the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://www.vault-tree.org

### Welcome!

The Vault Tree Project consists of:

* A JSON based DSL for building Distributed Crytographic Contracts
* A a Ruby library to execute these contracts
* A focal point of collaboration for developers writing and testing interesting crytographic contracts


### Install

Before you start:

* To use the library in your application or want to contribute code, you're in the right place.
* Before you pull the trigger on the install remember we have a Vagrant Box.

Okay, lets begin.

As a prerequisite get [libsodium] on you machine. This is the underlying cryptographic library that Vault Tree depends on.

[libsodium]: https://github.com/jedisct1/libsodium

* If you are on _OSX_ there is a [brew] package available. So just:

  ```
  brew install libsodium
  ```

[brew]: http://brew.sh/

* If you're on a Debian based system, there is no _apt-get_ package that I know of, but there
  are some helpful install scripts on the web. I've checked one of these in at:

  ```
  vault-tree/support/scripts/libsodium_ubuntu.sh
  ```

* If you're on Windows, the Vagrant install gives you a Linux virtual machine that helps you to pretend that you're not on Windows.

Now that you have libsodium, if you're a Ruby developer you know the drill from here:

```
gem install vault-tree
```

and then 

```
require 'vault-tree'
```

somewhere before you use it.


### Vagrant

I think it should be easy for you to get a Vault Tree development environment up and running. If you don't know about Vagrant, you should, it's awesome!
 
* Follow the [Vagrant] download and install steps
* Clone the Vault Tree Repo and go into it:

[Vagrant]: http://www.vagrantup.com/

```
  git clone git@github.com:VaultTree/vault-tree.git
  cd ~/path/to/vault-tree/
```

Now you just need to Vagrant Up!

```
  vagrant up
```

This will download and boot a pre-packaged Linux virtual machine with Vault-Tree and all dependencies already installed.

Once your VM is downloaded and built. You can go inside with:
 
```
  vagrant shh
```

As a developer working on Vault Tree you can now go to the VM's directory:

```
/vagrant 
```

and run `rake`. This will run all the tests and put you in a good spot to start exploring the code.

If you're not already familiar, take a few minutes to learn about how Vagrant will [sync your files] to and from the guest machine.

[sync your files]: http://docs.vagrantup.com/v2/getting-started/synced_folders.html

### Is it production ready?

Absolutely not. We have a long way to go.

Here are some of the big issues that I could use your help on as we move to version 1.0:

* This is a crypto application so vulnerabilities need to be identified and corrected. We need more eyes in this area.
* We we need to figure out if the supported keywords are sufficient to implement basic secure computation schemes.
  - For example, Digital Signatures and HMACs are not implemented but could be.
  - Should they be implemented? What is the use case? Ect. We need to have these conversations.
