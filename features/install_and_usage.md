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
