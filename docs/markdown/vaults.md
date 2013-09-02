
## Vaults

Vault Tree [Contracts] made be assembling simple structures called vaults. A
vault is like a digital lock box that stores a single unambiguous piece of
information that is need to execute the contract beyond a certain point.

The light bulb shoud turn on when you relize that vaults can hold not only
valuable information, but keys to other vaults.

[Contracts]:  http://vault-tree.org/overviews/contract

Let's take a look at an example:

```javascript
"vault_two_key": {
  "owner": "bob",
  "fill_with": "RANDOM_NUMBER",
  "lock_with": "VAULT_CONTENTS['bob_contract_secret']",
  "unlock_with": "VAULT_CONTENTS['bob_contract_secret']",
  "contents": "rSGrWGL4mEYtpuIaWO/iVGXAA5UUyLeeImSV3SBXzb+C7DW3"
}
```

The important thing to keep in mind is that, all vaults are **this simple**.
This convention for representing a vault should be sufficient to build any type of
simple or sophisticated contract.

### Vault Id

In this case we have `"vault_two_key"`. This tname should
be unique to a particular contract. Try to give meaning-full names that give
insite into the locked contents of the Vault itself.

### Owner

The owner name is also unique to the contract. A vault owner is the contract
party that is responsibily for Filling and Locking the vault. In this simple
case we have `"bob"`, but in an employment contract for example, we may have
vault owners named `"employer"` and `"employee"`.

It is the responsibility of the contract architect to assign vault owners in
such a way that there are no contract [moral hazards] or [perverse incentives].

[moral hazards]: http://en.wikipedia.org/wiki/Moral_hazard
[perverse incentives]: http://en.wikipedia.org/wiki/Perverse_incentive

### Fill With

The `"fill_with"` key identifies the contents of the vault. It can be either a
generated value or the contents of anther vault. In this example, the [Vault Tree
Interpreter] knows to generate simple random number, and place it in the vault.

[Vault Tree Interpreter]: http://vault-tree.org/developers/interpreter

### Lock With


### Unlock With
