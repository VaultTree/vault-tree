Given(/^Bob has the blank contract$/) do
  @contract = File.open(VaultTree::PathHelpers.one_two_three_contract).read
  @bob = VaultTree::AutoBots::Bob.new()
end

Given(/^he provides and signs his public keys$/) do
  @contract = VaultTree::V1::PartyAttributeSetter.new(@contract,
    party_label: "BOB",
    attribute: :verification_key,
    value: @bob.verification_key
  ).run

  @contract = VaultTree::V1::PartyAttributeSigner.new(@contract,
    party_label: "BOB",
    attribute: :verification_key,
    private_signing_key: @bob.signing_key
  ).run

  @contract = VaultTree::V1::PartyAttributeSetter.new(@contract,
    party_label: "BOB",
    attribute: :public_encryption_key,
    value: @bob.public_encryption_key
  ).run

  @contract = VaultTree::V1::PartyAttributeSigner.new(@contract,
    party_label: "BOB",
    attribute: :public_encryption_key,
    private_signing_key: @bob.signing_key
  ).run
end

When(/^Bob FLS the third vault$/) do
  pending
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
