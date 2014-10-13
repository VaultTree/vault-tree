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
