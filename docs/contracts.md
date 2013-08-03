### Distributed Cryptographic Contracts
The fundamental object in the Vault-Tree protocol is the **Distributed Cryptographic Contract**, _DCC_, or simply _Contract_.

You can think of a _DCC_ just as you would envision a common paper contract.
Just as a common contract is written on a leaf of paper, a _DCC_ is written on
single text file that can be copied and distributed to any interested party. 

Also, like a common contract, a _DCC_ is simply a voluntary agreement between two
or more counter-parties.

Unlike conventional contracts however, DCCs are do not rely on third parties to
ensure contract conditions are met. Once written, generated, and distributed, a DCC is **Self-Enforcing**.

This self-enforcing property is provided by carefully encrypting portions of
the contract, and using the Bitcoin [block chain] to precisely validate
fulfilment conditions.

#### DCC as a Decision Tree

Intuitively, a DCC is a deterministic [decision tree].
* Decision Tree nodes represent **Vaults**. 
* The tree-graph edge preceding each node represents the vault's **Unlocking Condition**.
* For each unlocking condition, there is a corresponding **Unlocking Certificate**,
  which acts as a computational [witness] to the fulfilment of the unlocking
  condition.

#### DCC as a Complete Contract

Because DCCs must be self-enforcing and programatically executable, they should by convention be a [complete contract].
In the context of the protocol this means the following:

* Each leaf vault in the Decision Tree should unlock a set of conditions that
  represent a valid contract end state.
* There does not exist a combination of conditions that would fail to unlock a
  leaf vault.


[complete contract]: http://en.wikipedia.org/wiki/Complete_contract
[decision tree]: http://en.wikipedia.org/wiki/Decision_tree_model
[certificate]: http://en.wikipedia.org/wiki/Certificate_(complexity) 
[witness]: http://en.wikipedia.org/wiki/Certificate_(complexity) 
