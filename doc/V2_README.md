[![Code Climate](https://codeclimate.com/github/VaultTree/vault-tree.png)](https://codeclimate.com/github/VaultTree/vault-tree)

## Vault Tree

_The Self Enforcing Contract_

Vault Tree helps you build crypto-based business logic into your application.

Before you begin make sure you checkout the [Vault Tree Homepage] for an overview of the project.

[Vault Tree Homepage]: http://vaulttree.github.io

### Install

```
gem install vault-tree
```

and then

```
require 'vault-tree'
```

somewhere before you use it.

### Dependencies

Bundler will build [libsodium] version (>= 0.4.3) on you machine. This is the underlying cryptographic library that Vault Tree depends on.

[libsodium]: https://github.com/jedisct1/libsodium

### Usage

The [Documentation] is filled with examples of how to execute Vault Tree contracts.

Also, a great way to get going is to simply run the tests:

* clone the repo
* bundle your dependencies
* run `rake`

You should see a full suite of green tests that will give you plenty of living
examples of how to use Vault Tree in your own application.

[Documentation]: https://www.relishapp.com/vault-tree/vault-tree/docs


### Writing Contracts

Here is what you need to know as you get started writting contracts for your application:

* A Vault Tree Contract is simply a [JSON] text file
* Every contract is composed of two parts:
  - The **Header** section, which includes helpful meta data
  - The **Vaults** section, which can be any collection of _vaults_ that form the
    contract.
* The way in which you, the contract author, organize the vaults will determine the **Self-Enforcing Terms** of your contract.
* Each vault will typically contain either an **external input** string that is provided by one of the contract participants, a key to anther vault, or JSON subcontract.

### Writing and Simulating Contracts

As you start working through the logic of your contracts, consider the
following:

* Your Vault Tree Contract may need to multple people or agents.
* As you write a contract, you may need a way to test it out and think through all the different scenarios.
* When the final contract is complete it might involve network calls to pass it between parties, queries to a third party network, such as the Bitcoin Block Chain, or some other step involving the outside world.

It would be helpful to have a way to **Test and Simulate** how this contract will be used in real life.

[Cucumber] is a tool designed to test complicated full stack web applications. However, we are going to use it for a slightly different purpose.

[Cucumber]: https://github.com/cucumber/cucumber

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

We can associate each one of these steps in the scenario with some simple Ruby code that interacts with the Vault Tree API.

Not only can we easily run the contract throught the library to test that it works, we have a straight forward mechanism for simulating otherwise complicated steps like sending the JSON representation of the contact _over the wire_.

The example contracts in this documentation are a small collection that have been assembled for illustrative purposes. We can learn from these simplified examples, and use them as the foundation for more complex _real world_ contracts.

[JSON]: http://www.json.org
[Vault Tree Homepage]: http://www.vault-tree.org
[Vault Tree Project]: http://www.vault-tree.org

## Contracts and Vaults

### Contracts

Now that we've explored the ideas of a **Contract**, **Contract Enforcement**, and a **Decision Tree**, we can better understand what makes a Vault Tree Contract unique.

#### Vaults

Vault Tree Contracts are made by assembling simple structures called **Vaults**. A vault is like a digital lock box that stores a single unambiguous piece of information.

The light bulb should turn on when you realize that vaults can hold not only valuable external information, but the **keys to other vaults**.

#### Contract Properties

Like regular contracts, Vault Tree Contracts are still modeled as a Decision
Tree of events and outcomes. Unlike regular contracts, they have the added
benefit of being a **Distributed Cryptographic Contract**. This means: 

* To each event in the contract we add a corresponding vault 
* A contract becomes a structured collection of vaults
* Each Vault encrypts a piece of secret information. This can be external
information such as a _URL_ or a _Bitcoin Wallet Address_. More often, a vault will contain the unlocking key to another vault in the contract.
* The way in which the contract author **chooses to structure** the releationship between vaults, will determine how the contract is **Enforced**.
* It is the responsibility of the contract author to arrange vaults so that there are no contract [moral hazards] or [perverse incentives].

[moral hazards]: http://en.wikipedia.org/wiki/Moral_hazard
[perverse incentives]: http://en.wikipedia.org/wiki/Perverse_incentive

#### Complete Contracts

Because Vault Tree Contracts should be **self-enforcing** and **programatically executable**, they are by convention [complete contracts].

In the context of the interpreting library this means the following:

* Each **Leaf Vault** in the graph should unlock a set of conditions that represents an acceptable contract **Outcome**.
* There does not exist any combination of conditions that would ultimately fail to unlock a leaf vault.

[complete contracts]: http://en.wikipedia.org/wiki/Complete_contract

#### Contracts as JSON Files

Just as a common contract is often written on a piece of paper, a Vault Tree contract is typed into a single text file that can be copied and distributed to anyone.

We chose the [JSON] file format for respresenting contracts. JSON is becoming the mainstream internet serialization format and can be easily read by both humans and computers.

[JSON]: www.json.org


### Vaults

We discussed earlier how Vault Tree contracts are just a collection of vaults
arranged to enforce the terms of the contract.

Let's take a look at an example vault:

```javascript
"bob_random_key": {
  "contents": "RANDOM_KEY",
  "lock_key": "KEY['bob_first_vault_key']",
  "unlock_key": "KEY['alice_third_vault_key']",
  "ciphertext": "dc92c330e5f911e3ac100800200c9a6648ab522cf91739ade ... "
}
```

It's important to keep in mind that, **every** vault follows this format. This
convention for representing a vault should be sufficient to build any type of
simple or sophisticated contract.

#### Vault Id

The **Vault Id** can be thought of as both the name and the **unique** identifier of the vault.

In this case we have:

```
"bob_random_key"
```

Try to give meaningful names that give insight into the locked contents held within the vault.

#### Contents

The **"contents"** field identifies the source of the [Plaintext] contents of the
vault. It can be:

* a value generated by the Vault Tree library.
* external information that is brought into the contract.
* the contents of anther vault.

In the example above, the Vault Tree interpreter knows to generate a simple random number, and place it into the vault.

[Plaintext]: http://en.wikipedia.org/wiki/Plaintext 

#### Lock With

The **lock_with** field identifies the source of the vault's **Locking Key**. 


#### Unlock With

The **unlock_with** field naturally identifies the source of the vault's **Unlocking Key**.

It may not be obvious, but the reference to the Unlocking key does not necessarily need to be the same as the reference to the **Locking Key**. Here are some examples of where this could be the case: 

* The same key is used to lock and unlock the vault, but copies of this key are held in two separate vaults. Take a look at the **Block Chain Key Transfer** contract to see a good example of this.
* Vault Tree supports the notion of an **Asymmetric Vault** through the _DSL Keyword_

```
DH_KEY
```

An Asymmetric Vault is locked and unlocked with the help of a [Public-Private](http://en.wikipedia.org/wiki/Public-key_cryptography) keypair. Vault Tree's underlying cryptographic library makes this possible by implementing a cutting edge variant of the [ECDH] key exchange protocol.

[ECDH]: http://en.wikipedia.org/wiki/Elliptic_curve_Diffie%E2%80%93Hellman

#### Ciphertext

As you would expect, this field references the encrypted contents of the vault. In the example above you can see the _Hex_ encoded ciphertext:

```
"ciphertext": "dc92c330e5f911e3ac100800200c9a6648ab522cf91739ade ... "
```
Here are some items to keep in mind:

* Vaults are either **Empty** or **Closed**, this corresponds to either a **Blank Value** or a **Ciphertext Value**
* If we want everyone to have access to the contents we simply lock the closed vault with a known public value. For a description on how to do this in practice see the _DSL Keyword_

```
UNLOCKED
```

### Contracts as Decision Trees

Contracts can be modeled as a [Decision Tree]. Intuitively this means that:

* The set of contract events and final outcomes for all parties involved can be represented as a [Directed Graph].
* Often, the graph will take the form of a [Tree].
* **Events** are represented as nodes in the graph, **Outcomes** are events that correspond to [Leaf Nodes].
* Once a contract has been **Negotiated**, contract execution proceeds down the graph beginning at the [Root Node].
* Edges in the graph correspond to real world conditions that must be met before making a valid trasition between two events.
* **Well Written** contracts correspond to well structured graphs.

[Directed Graph]: http://en.wikipedia.org/wiki/Directed_graph
[Tree]: http://en.wikipedia.org/wiki/Tree_%28graph_theory%29 
[Decision Tree]: http://en.wikipedia.org/wiki/Decision_tree
[Leaf Nodes]: http://en.wikipedia.org/wiki/Tree_%28data_structure%29#Terminology
[Root Node]: http://en.wikipedia.org/wiki/Tree_%28data_structure%29#Terminology

### Install

You can find the install instructions on the Github [README].

[README]: https://github.com/VaultTree/vault-tree

### Usage

Executing contracts in your Ruby application is is simple.

Instantiate a new contract object with its corresponding JSON:

```ruby
  @contract = VaultTree::Contract.new(contract_json)
```

From here you have two methods available:

```ruby
  @contract.close_vault('vault_id', external_input = {})
```

```ruby
  @contract.open_vault('vault_id', external_input = {})
```

### Testing

A great way to get going is to simply run the tests:

* clone the repo
* bundle your dependencies
* run `rake`

You should see a full suite of green tests that will give you plenty of living
examples of to use Vault Tree in your own application.

[Documentation]: https://www.relishapp.com/vault-tree/vault-tree/docs

### Overview

Vault Tree is a software framework that makes it easy to author and execute **Distributed Cryptographic Contracts.**

These are sort of like [Smart Contracts], but designed for for web developers building applications against the Bitcoin Block Chain.

[Smart Contracts]: http://en.wikipedia.org/wiki/Smart_contract

## Background

Contracts are fundemental building blocks of our modern economy. They are simply voluntary and structured aggreements between two or more parties.

There are many examples that we are already familiar with from our daily lives such as employment contracts and rental agreements. Also, the sophisticated investment instruments that drive our modern financial system are just examples of standardized contracts.

It's been know for quite a while that well structured contracts can be thought of as a computer programs. If we bring cutting edge [cryptographic libraries], and distributed virtual currencies such as [Bitcoin] into the picture, can we change the way we view the problem of **contract enforcement**?

You can think of Vault Tree as a collection of tools to help web developers explore a new way of thinking about contracts.

[cryptographic libraries]: http://en.wikipedia.org/wiki/Cryptography
[Bitcoin]: http://bitcoin.org/en/ 

## From .nav File
-- overview.md (Overview)
-- decision_tree.md (Decision Trees)
-- contracts_and_vaults.md (Contracts and Vaults)
-- install_and_usage.md (Install and Usage)
-- manipulating_contracts.md (Manipulating Contracts)
-- keywords (Keywords):
-- exceptions.feature (Runtime Exceptions)
-- contracts (Example Contracts):
-- contributing_to_vault_tree.md (Contributing to Vault Tree)
-- native (Native Apps):


## Contents


The `CONTENTS` keyword is used to fetch the contents of another vault:

```javascript
"contents": "CONTENTS['some_string']"
```

It takes one argument, the name of the vault holding the desired contents.

The contents keyword should only be used in the **"contents"** field. If you want to use it in either

the **lock_with** or **unlock_with** fields, you should consider the alias `KEY` instead.

Here is an example of a vault that makes use of the `CONTENTS` keyword.

```javascript
"locked_message":{
  "contents": "CONTENTS['message_locked_with_random_key']",
  "lock_key": "KEY['unlocked_random_key']",
  "unlock_key": "KEY['unlocked_random_key']",
  "ciphertext": ""
}
```

## Decryption Key

Decryption keys are asymmetric private keys.

```javascript
"contents": "DECRYPTION_KEY",
```

When establishing a public private key pair, you need to generate the decryption
key first and reference its vault when building the associated public key.


## DH Key

```javascript
DH_KEY['public_key_vault_id','decryption_key_vault_id']
```
This keyword enables the creation of **Asymmetric Vaults**.

DH Keys are very powerful and Vault Tree is written to encourage contract authors to make use of asymmetric encryption.

The underlying cryptographic library provides a set of expertly crafted opinionated conventions for using public keys. One such convention is [Mutual Authentication](http://en.wikipedia.org/wiki/Mutual_authentication) accomplished with the Elliptic Curve Diffie-Hellman key exchange protocol.

Feel free to study the example contracts for some good ideas on how to use this powerful keyword.

## External Inputs

The Vault Tree interpreter does not interact directly with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that all necessary external inputs will be explicitly passed in.

Use the EXTERNAL_INPUT Keyword when you want to fill a vault with a string from
the outside environment.

Although you can lock and unlock vaults directly with an EXTERNAL_INPUT string
if it happens to be properly formated, it is recommended that you do not do this.

Instead, lock and unlock vaults with external strings using the EXTERNAL_KEY phrase.
EXTERNAL_KEY ensures your password is run through a secure hash before it is used to
lock contents. Hashing guarentees a properly padded vault key and keeps the locked vault
more secure if you have a weak password.

## Public Encryption Key

```javascript
  "contents": "PUBLIC_ENCRYPTION_KEY['decryption_key_vault_id']",
```

Public encryption keys are derived from their corresponding private decryption key.

This Keyword takes one argument the vault ID containing the associated private
key.

Public encryption keys and private decryption keys are used to build DH Keys
to lock and unlock asymmetric vaults.

## Unlocked

```javascript
  "lock_key": "UNLOCKED",
  "unlock_key": "UNLOCKED"
```

This keyword should be used to make vault contents accessable to anyone.

When the contract interpreter reads this keyword it simply hashes the actual string _"UNLOCKED"_ and uses the resulting digest as the symmetric vault key.


## VT

## vt

A simple command line interface for interacting with the [Vault Tree] library.

[Vault Tree]: http://vaulttree.github.io

### Background

_vt_ is meant to be a very light interface around the [Vault Tree] Ruby library.

Take a look at the [homepage] and [library] before you begin to learn more about the overall project.

[homepage]: http://vaulttree.github.io
[library]: https://github.com/VaultTree/vault-tree
[Vault Tree]: http://vaulttree.github.io

### Install

```
  gem install vt
```

### Usage

Like many of your favorite UNIX tools, _vt_ operates as a filter in the _STDIN_ and _STDOUT_ stream. Pipe your Vault Tree JSON contract into _vt_ and simply specify which vault you want to open or close.

#### Closing Vaults

When the vault you are closing requires no external input do this:

```shell
  cat /path/to/your_contract.json | vt close vault_id
```

This command sends the newly modified JSON contract back to _STDOUT_.

To save changes to your contract, just pipe _vt_ output to a text file.

```shell
  cat ~/my_contract.json | vt close_vault vault_id > ~/my_modified_contract.json
```

#### Opening Vaults

Again, with no external input simply:

```shell
  cat /path/to/your_contract.json | vt open vault_id
```

This will send the contents of the specified vault to _STDOUT_.

#### Formating Contracts

Take a look at this command:

```shell
  cat /path/to/your_contract.json | vt format
```

This will add some nice coloring and line indentation to make it easier to read
your contract in the terminal.

Since `vt close <id>` always returns a contract, you may want do something like this:

```shell
  cat ~/my_contract.json | vt close_vault vault_id | vt format
```

to get a better look at your modified contract.

##### Not Valid JSON

Remember, the `vt format` command changes the bytes on your contract string and invalidates the JSON. Only use this command to help make your terminal output more readable.

#### External Input

_vt_ allows you to pass external input into your contract via shell variables.

For example, suppose you have a `contract.json` file in your `~/` dir and it looks like
this:

```javascript

{
  "header": {},
  "vaults": {
    "message":{
    "description": "a simple message",
    "fill_with": "EXTERNAL_INPUT['msg']",
    "lock_with": "EXTERNAL_KEY['my_secret']",
    "unlock_with": "EXTERNAL_KEY['my_secret']",
    "contents": "25cc8ed8c75e665b911788bb5ba1520a05d96e8108868ef3d14c3b0aa45"

    }
  }
}

```

To return the decrypted vault contents back to STDOUT you need to provide the Vault Tree Library with the value for _my_secret_.

When you issue the following command:

```shell
  cat ~/contract.json | vt open message my_secret
```

The _vt_ cli assumes by convention there is a variable ` $my_secret ` defined
with the secret value in the current shell. This allows you to get sensitive data into Vault Tree without necessarily exposing it to your shell history logs.

Take a look at the [documentation] and the tests in the actual code libarary to get a better idea of how to properly reference external input within your contracts.

[documentation]: http://vaulttree.github.io

### Old Note On Docs
The [Documentation] is filled with examples of how to execute Vault Tree contracts.

Also, a great way to get going is to simply run the tests:

* clone the repo
* bundle your dependencies
* run `rake`

You should see a full suite of green tests that will give you plenty of living
examples of how to use Vault Tree in your own application.

[Documentation]: https://www.relishapp.com/vault-tree/vault-tree/docs


The [Documentation] is filled with examples of how to execute Vault Tree contracts.

Also, a great way to get going is to simply run the tests:

* clone the repo
* bundle your dependencies
* run `rake`

You should see a full suite of green tests that will give you plenty of living
examples of how to use Vault Tree in your own application.

[Documentation]: https://www.relishapp.com/vault-tree/vault-tree/docs
