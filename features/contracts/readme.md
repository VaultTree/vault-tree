Contracts are a central part of the [Vault Tree Project]. Here is what you
need to know:

* A Vault Tree Contract is simply a [JSON] text file
* Every contract is composed of two parts:
  - The **Header** section, which includes helpful meta data
  - The **Vaults** section, which can be any collection of _vaults_ that form the
    contract.
* The way in which you, the contract author, organize the vaults will determine the **Self-Enforcing Terms** of your contract.
* Each vault will typically contain either an **external input** string that is provided by one of the contract
  participants, or a key to anther vault.

### Writing and Simulating Contracts

If you've made it to this far, then you're ready to build something. You're
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

Given(/^Alice has the blank contract$/) do
  contract_path = VaultTree::ContractsRepo::PathHelpers.core_contracts('one_two_three.0.7.0.json')
  @contract_json = File.read(contract_path)
end

When(/^she locks all of her attributes$/) do
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @contract_json = @contract.as_json
  @bobs_external_input = {"congratulations_message" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, @bobs_external_input)
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

### Design Opinions

Vault Tree was written to give contract authors a large amount of flexibilty.
There are however some design constraints that were put in place to get the
community off to a good start.

I'll update these in the coming months as we get some more experience writing simple contracts.

* The Vault Tree interpreter is stateless and always takes a contract as an input
* All external input required for contract execution must be provided to the
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
