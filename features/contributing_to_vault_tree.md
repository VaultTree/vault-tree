### Submitting a New Contract

The example contracts in this documentation are a small collection that have been assembled for illustrative purposes. We can learn from these simplified examples, and use them as the foundation for more complex _real world_ contracts.

I encourage **anyone** interested, to submit new and innovative contracts. Here are some items to keep in mind when you are ready to contribute:
  * Vault Tree was designed so that smart people of all different backgrounds could design and execute contracts. Don't feel that you need to be a programmer to get started.
  * Try to familiarize yourself with Github best practices. Do you best understand Pull Requests before you attempt to submit.

### Design Opinions

Vault Tree was written to give contract authors a large amount of flexibilty.  There are however some design constraints that were put in place to get the community off to a good start.

I'll update these in the coming months as we get some more experience writing simple contracts.
  * The Vault Tree interpreter is stateless and always takes a contract as an input
  * All external data required for contract execution must be provided to the interpreter by the run time that is invoking the API. For example, there are no plans for the interpreter to make any network requests or do file IO.

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

* The website documentation is generated from the `*.features/` and `*.md` files in this project.
* We will standardize on Github flavored markdown
* As you build contracts and solve problems please consider contributing back to the documentation. It's time consuming but extremely important for the life of the project.
* Respect the established file naming conventions. Docs are generated with a build tool that makes assumptions.
