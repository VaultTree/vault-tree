### Install

As a prerequisite, get [libsodium] version (>= 0.4.3) on you machine. This is the underlying cryptographic library that Vault Tree depends on.

[libsodium]: https://github.com/jedisct1/libsodium

* If you are on _OSX_ there is a [brew] package available. So just:

  ```
  brew install libsodium
  ```

[brew]: http://brew.sh/

* If you're on a Debian based system, there is no _apt-get_ package that I know of, but there
  are some helpful install scripts on the web.

Now that you have libsodium, if you're a Ruby developer you know the drill from here:

```ruby
gem install vault-tree
```

and then

```ruby
require 'vault-tree'
```
somewhere before you use it.

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
