#### Vault Tree Contracts

Now that we've explored the ideas of a _Contract_, _Contract Enforcement_, and
_Decision Trees_, we can better understand what Vault Tree brings to the party.

##### Vaults

Vault Tree Contracts are made be assembling simple structures called _Vaults_. A
vault is like a digital lock box that stores a single unambiguous piece of
information that is needed to continue execution of the contract beyond a certain point.

The light bulb should turn on when you relize that vaults can hold not only
valuable external information, but the keys to other vaults!

Like regular contracts, Vault Tree contracts are still modeled as a Decision
Tree of events and outcomes. Unlike regular contracts, they have the added
benefit of being a *Distributed Cryptographic Contract*. This means:

* To each event event in the contract we add a corresponding vault 
* A contract becomes simply a collection of vaults
* Each Vault encrypts a piece of secret information. This can be external
information such as URL or Bitcoin Wallet Address. More often then not, a vault
will contain the unlocking key to another vault in the contract.
* The way in which the contract author chooses to structure the releationship
between vaults, determins the way in which the contract is *enforced*.

##### Complete Contracts

Because Vault Tree Contracts should be self-enforcing and programatically executable, they should by convention be a [complete contract].
In the context of the interpreter this means the following:

* Each leaf vault in the graph should unlock a set of conditions that represents
an acceptable contract _Outcome_.
* There does not exist a combination of conditions that would ultimately fail to unlock a leaf vault.

[complete contract]: http://en.wikipedia.org/wiki/Complete_contract


##### Contracts as JSON Files

Just as a common contract is often written on a leaf of paper, a Vault Tree contract
is typed in a single text file that can be copied and distributed to anyone.

We chose the [JSON] file format for respresenting contracts. JSON is an emerging
webstandard that can be easily read by both humans and computers.

[JSON]: www.json.org
