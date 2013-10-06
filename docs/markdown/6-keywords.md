#### Keywords

The Vault Tree DSL provides keywords that allow you to craft the behavior of your contract in useful ways.

Keywords are expressed with all capital letters and take **Vault Ids** as arguments.

##### Contents 

The contents keyword is used to fetch the contents of another vault. For
example: 

```
"fill_with": "CONTENTS['vault_three_key']",
```

It takes one argument, the name of the vault holding the desired contents.

The contents keyword can be used in the **fill_with**, **lock_with** and **unlock_with** fields.

##### Master Passphrase 


```
"lock_with": "MASTER_PASSPHRASE",
"unlock_with": "MASTER_PASSPHRASE"
```

The master password can be thought of as the secure password for the system that is executing the contract. It should never be shared or transfered between parties.

The Vault Tree prevents this value from ever being stored within a vault. If you attempt to store the master password within a vault, an exception will be thrown.

As a best practice you should minimize the number of vaults that are locked or unlocked with your master password.

Specifically, consider randomly generating a contract secret and then locking it
with your master password. Then you can lock other vaults with this randomly generated ephemeral secret
when you want store confidential information.

##### Shared Key

The keyword

```
SHARED_KEY['public_key_vault_id','decryption_key_vault_id']
```

enables the creation of **Asymmetric Vaults**.


Shared keys are very powerful and Vault Tree is written to encourage contract authors to make use of asymmetric encryption.

The underlying cryptographic library provides a set of expertly crafted opinionated conventions for using public keys. One such convention is [Mutual Authentication](http://en.wikipedia.org/wiki/Mutual_authentication) accomplished with the Elliptic Curve Diffie-Hellman key exchange protocol.

Feel free to study the example contracts for some good ideas on how to use this powerful keyword.

##### Random Number

The keyword 

```
RANDOM_NUMBER
```

behaves as expected. 

Random number she using the fill with field only
It generates a random number and places it in a vault

When used, the Vault Tree library generates the Cryptographic hash of a random number and places it in the designated vault.

You should use this keyword to build secure symmetric Vault keys.

##### Public Encryption Key

```
  "fill_with": "PUBLIC_ENCRYPTION_KEY['decryption_key_vault_id']",
```

Public encryption keys are derived from their corresponding private decryption key.

The public encryption key key word takes one argument the vault ID containing the private key associated private key

Public encryption keys and private decryption keys are used to build shared keys
to lock and unlock asymmetric vaults.

##### Decryption Key

Decryption keys are asymmetric private keys.

```
"fill_with": "DECRYPTION_KEY",
```

When establishing a public private key pair, you need to generate the decryption key first and reference its vault when building the associated key pair.

##### Unlocked

```
  "lock_with": "UNLOCKED",
  "unlock_with": "UNLOCKED"
```

This keyword should be used to make vault contents accessable to anyone.

When the contract interpreter reads this keyword it simply hashes the string _"UNLOCKED"_ and uses the resulting digest as the symmetric vault key.

##### External Data

The Vault Tree interpreter does not interact directly with outside networks. Its
repsonsibility is limited to opening and closing vaults under the assumption
that  all necessary external data will be explicitly passed in.

In short, you can expect the interpreter to stick to the following rules:

* External Data is relevent only when **closing** a vault.
* When a vault is being opened, the interpreter expects that all the necessary data has already been locked somewhere in the contract.
* External Data must be a string
