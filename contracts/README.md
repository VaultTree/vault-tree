## Vault Tree Contracts
A small library of illustrative example contracts

### Welcome

If you are coming to this page from Github and are unfamiliar with Vault Tree,
please take a look at the [Vault Tree Homepage] for an overview of the project.

### Contracts Overview

Contracts are a central part of the [Vault Tree Project]. Here is what you
need to know:

* A Vault Tree Contract is simply a [JSON] text file
* Every contract is composed of two parts:
  - The **Header** section, which includes helpful meta data
  - The **Vaults** section, which can be any collection of _vaults_ that form the
    contract.
* The way in which you, the contract author, organize the vaults will determine the **Self-Enforcing Terms** of your contract.
* Each vault will typically contain either an **external data** string that is provided by one of the contract
  participants, or a key to anther vault.

### Getting Started

You're in the right place if you:

* Want to run the library against some existing contracts
* Write and simulate your own cryptographic contracts
* Submit new Vault Tree contracts back to the community

If you want to use the Vault Tree library in an application or contribute to
the core code base, you should take a look at the [main repo].

### Install With Vagrant

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
and run

```
rake
bundle
```

This will pull down the latest version of the code from [Ruby Gems] and then run all the core contracts and put you in a good spot to start exploring the library.

If you're not already familiar, take a few minutes to learn about how Vagrant will [sync your files] to and from the guest machine.

[vault-tree]: https://github.com/VaultTree/vault-tree
[main repo]: https://github.com/VaultTree/vault-tree
[Ruby Gems]: http://rubygems.org

### Install With Bundler

If you are comfortable with Ruby and Bundler checkout the README in the [main repo] to get started with a direct install.

[main repo]: https://github.com/VaultTree/vault-tree

### Writing and Simulating Contracts

**LET'S DO THIS!**

If you've made it to this far, then you're ready to build some stuff. You're
thinking to yourself:

* For my Vault Tree Contract to be useful it probably needs to involve more than one person.
* I think I can write a contract, but I really need a way to test it out and think through all the different scenarios.
* When my final contract is complete it might involve network calls to pass it
  between parties, queries the Bitcoin Block Chain, or some other crazy step involving the outside world.

What I really need is a way to **Simulate** how the contract will be used in real life ...

Enter [Cucumber].

[Cucumber]: https://github.com/cucumber/cucumber

Cucumber is a tool designed to test complicated full stack web applications. However, we are going to use it for a slightly different purpose.

Take a look at this simple example:

```Gherkin
Scenario: Alice and Bob Execute the One Two Three Contract
  Given Alice has the blank contract
  When she locks all of her attributes
  And she sends the contract to Bob
  Then Bob can access all of her public attributes
  When Bob locks his attributes
  And He fills and locks each of the three main vaults
  Then Alice can execute the contract to recover the final message
```

Great. So we wrote down how the contract is used in some funny looking format  ... so what.

Well, what if we associate each one of these steps in the scenario with some simple Ruby code that interacts with the Vault Tree API. Here are the first three step definitions:

```Ruby
# This file: "features/core/one_two_three/one_two_three.steps.rb"
# Associated Contract: "core/one_two_three.0.7.0.json"

Given(/^Alice has the blank contract$/) do
  contract_path = VaultTree::ContractsRepo::PathHelpers.core_contracts('one_two_three.0.7.0.json')
  @contract_json = File.read(contract_path)
end

When(/^she locks all of her attributes$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @contract_json = @contract.as_json
  @bobs_external_data = {"congratulations_message" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'BOB_SECURE_PASS', external_data: @bobs_external_data)
end
```

Not only can we easily run the contract throught the library to test that it
works, we have a straight forward mechanism for simulating otherwise complicated
steps like sending the JSON representation of the contact _over the wire_.

Some items to keep in mind when you run Cucumber scenarios:

* Run `rake` instead of `cucumber` when in the VM `/vagrant` dir
* This will:
  - Take care of the wierd cucumber configuration flags needed to handle the unconventional directory structure.
  - Execute all cucumber scenarios associated with contracts in the `/core` directory

### Submitting to the Vault Tree Project

The [Contracts Repository] is a small collection of examples that have
been assembled for illustrative purposes.

We can learn from these simplified examples, and use them as the foundation for
more complex _real world_ contracts.

I encourage **anyone** interested, to submit new and innovative contracts. Here are
some items to keep in mind when you are ready to contribute:

* Vault Tree was designed so that smart people of all different backgrounds
  could design and execute contracts. Don't feel that you need to be a programmer to
  get started.
* The two relevent folders in the [Contracts Repository] are [core] and [lab].
  All new contracts should initialy start in the [lab] folder. Once we determine
  it's ready and potentially useful, it will be promoted to the [core] folder.

### Design Opinions

Vault Tree was written to give contract authors a large amount of flexibilty.
There are however some design constraints that were put in place to get the
community off to a good start.

I'll update these in the coming months as we get some more experience writing simple contracts.

* The Vault Tree interpreter is stateless and always takes a contract as an input
* All external data required for contract execution must be provided to the
interpreter by the run time that is invoking the API. For example, there are no
plans for the interpreter to make any network requests or do file IO.

##### Notes for Developers

* Let's practice strict [semantic versioning] in managing our contracts.
* Edit contracts with the help of an application like [js beatifier].
* Ensure proper JSON format with a tool like this [json parser].
* Changes to core contracts should produce clean Git diffs.

[lab]: https://github.com/VaultTree/contracts/tree/master/lab
[core]: https://github.com/VaultTree/contracts/tree/master/core
[Contracts Repository]: https://github.com/VaultTree/contracts 
[JSON]: http://www.json.org 
[Vault Tree Homepage]: http://www.vault-tree.org
[Vault Tree Project]: http://www.vault-tree.org
[semantic versioning]: http://semver.org
[js beatifier]: http://jsbeautifier.org 
[json parser]: http://json.parser.online.fr
[json]: http://json.org

##### Website Documentation

A few comments on documentation:

* The website documentation is generated from the `docs/` files in this project.
* We will standardize on Github flavored markdown
* As you build contracts and solve problems please consider contributing back to the
  documentation. It's time consuming but extremely important for the life of the project.
* Respect the established file naming conventions. The Vault Tree Homepage Docs are generated with a
  build task that makes assumptions.
