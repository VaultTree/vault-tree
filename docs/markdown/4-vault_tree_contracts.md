#### Vault Tree Contracts

Now that we've explored the ideas of a **Contract**, **Contract Enforcement**, and a **Decision Tree**, we can better understand what makes a Vault Tree Contract unique.

##### Vaults

Vault Tree Contracts are made be assembling simple structures called **Vaults**.

A vault is like a digital lock box that stores a single unambiguous piece of information. This piece of information is needed to continue the execution of a contract beyond a certain event.

The light bulb should turn on when you relize that vaults can hold not only valuable external information, but the **Keys to other vaults**.

Like regular contracts, Vault Tree contracts are still modeled as a Decision
Tree of events and outcomes. Unlike regular contracts, they have the added
benefit of being a **Distributed Cryptographic Contract**. This means: 

* To each event event in the contract we add a corresponding vault 
* A contract becomes simply a collection of vaults
* Each Vault encrypts a piece of secret information. This can be external
information such as URL or Bitcoin Wallet Address. More often though, a vault will contain the unlocking key to another vault in the contract.
* The way in which the contract author **chooses to structure** the releationship between vaults, will determine how the contract is **Enforced**.

##### Complete Contracts

Because Vault Tree Contracts should be **self-enforcing** and **programatically executable**, they are by convention [complete contracts].

In the context of the interpreting library this means the following:

* Each **Leaf Vault** in the graph should unlock a set of conditions that represents an acceptable contract **Outcome**.
* There does not exist any combination of conditions that would ultimately fail to unlock a leaf vault.

[complete contracts]: http://en.wikipedia.org/wiki/Complete_contract

##### Contracts as JSON Files

Just as a common contract is often written on a piece of paper, a Vault Tree contract is typed into a single text file that can be copied and distributed to anyone.

We chose the [JSON] file format for respresenting contracts. JSON is becoming the mainstream internet serialization format and can be easily read by both humans and computers.

[JSON]: www.json.org
