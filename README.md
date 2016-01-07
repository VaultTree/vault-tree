[![Code Climate](https://codeclimate.com/github/VaultTree/vault-tree.png)](https://codeclimate.com/github/VaultTree/vault-tree)

## Vault Tree

_cryptography for the rest of us_

Vault Tree is high level JSON-based crypto library for application developers.

Checkout the [homepage] for an overview of the project.

[homepage]: http://vaulttree.github.io

### Install and Setup

##### Prerequisites

Ensure that you have the following available on your system:

* MRI `ruby 1.9.3` or higher
* A suitible build tool for compiling the [libsodium] crypto library

In most cases you'll have the necessary build tools on your machine. Bundler should find the right compiler.

These are the only external dependencies.

[libsodium]: https://github.com/jedisct1/libsodium

##### Source Code

The prefered install method is to clone the source code directly to your machine. To do so run the following in directory of your choice:

```
git clone git@github.com:vaulttree/vault-tree.git
```

##### Compile Native Extentions

From inside the `vault-tree/` directory run:

```
  bundle install
```

Bundler will build [libsodium] version (>= 0.4.3) on you machine. This is the underlying cryptographic library that Vault Tree depends on.

[libsodium]: https://github.com/jedisct1/libsodium

##### Path

Make sure you have `vault-tree/bin/vt` in your `$PATH`

### Quick Start

##### vaults.json

Save the following to a file named `empty_vaults.json`:

```
{
  "vaults":{
    "quick_start": {
      "contents": { "external_input": "qs_message" },
      "lock_key": { "sym_key": { "external_input": "qs_key" } },
      "unlock_key": { "sym_key": { "external_input": "qs_key" } },
      "ciphertext": ""
    }
  }
}
```

##### key and message

Generate a random key and save it to your shell.

```
QS_KEY=$(vt key)
```

Save a secret string to your shell.

```
MESSAGE='MY_SECRET_MESSAGE'
```

##### close your vault

```
cat empty_vaults.json | vt close quick_start qs_message=$MESSAGE qs_key=$QS_KEY > vaults.json
```

Take a look at your new `vaults.json` file. You should see something like this:

```
{
  "vaults":{
    "quick_start": {
      "contents": { "external_input": "qs_message" },
      "lock_key": { "sym_key": { "external_input": "qs_key" } },
      "unlock_key": { "sym_key": { "external_input": "qs_key" } },
      "ciphertext": "34d2f43c5d1d40a15381044340c775aa1e85e321b17f11bdafe1960f3b8bbdea894d"
    }
  }
}
```

##### open the vault

To recover your encrypted message run:

```
cat vaults.json | vt open quick_start qs_key=$QS_KEY
```

and your plaintext message should be sent to the terminal.

##### That's It!

Like many of your favorite UNIX tools, _vt_ operates as a filter in the _STDIN_ and _STDOUT_ stream. Pipe your Vault Tree JSON vault collection into _vt_ and specify which vault you want to open or close.

If you like JSON and simple text-based workflow, then Vault Tree can help you manage basic encryption tasks.

In addition to simple use cases you can keep reading to learn about how symmetric, asymmetric, and nested vaults can help you build crypto-based business logic into your applications and workflows.

## CLI Examples

Take a look at the `spec/vault_collections/*` test for more examples on how to use Vault Tree at the command line.

## Early Stage Development

Vault Tree will continue to remain in the proof of concept stage for a while. Use at your own risk. There are many isses that need to be address before you can rely on the library for secure applications.
