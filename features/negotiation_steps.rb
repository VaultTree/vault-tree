Given(/^Bob has the blank contract$/) do
  @contract = File.open(VaultTree::PathHelpers.one_two_three_contract).read
  @bob = VaultTree::AutoBots::Bob.new()
end

Given(/^he provides his public key$/) do
  opts = {
    label: 'BOB',
    verification_key: @bob.verification_key,
    public_encryption_key: @bob.public_encryption_key,
    private_signing_key: @bob.private_signing_key
  }
  opts[:verification_key].should be_an_instance_of(String)
  opts[:public_encryption_key].should be_an_instance_of(String)
  opts[:private_signing_key].should be_an_instance_of(String)
  @contract = VaultTree::V1.set_public_keys(@contract, opts)
end

When(/^Bob FLS the third vault$/) do
  # Fill Vault
  opts = { private_key: @bob.private_key, label: '[1,2,3]', content: "Congrats!" }
  @contract = VaultTree::V1.fill_vault(@contract, opts)

  # Lock Vault
  opts = {private_key: @bob.private_key, label: '[1,2,3]'}
  @contract = VaultTree::V1.lock_vault(@contract, opts)

  # Sign Vault
  opts = {private_key: @bob.private_key, label: '[1,2,3]'}
  @contract = VaultTree::V1.lock_vault(@contract, opts)
end

When(/^Bob FLS the second vault$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^Bob FLS the first vault$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^each vault is properly locked and signed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^Bob FLS each contract Vault$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^Bob Affirms, Signs, and Sends the contract to Alice$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Alice has and is ready to enforce the contract$/) do
  pending # express the regexp above with the code you wish you had
end
