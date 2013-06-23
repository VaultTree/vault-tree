Given(/^Bob has the blank contract$/) do
  @contract = File.open(VaultTree::PathHelpers.one_two_three_contract).read
  @bob = VaultTree::AutoBots::Bob.new()
end

Given(/^he writes and signs his public attributes$/) do
  @contract = @bob.write_public_attrs(@contract)
  @contract = @bob.sign_public_attrs(@contract)
end

When(/^Bob FLS the third vault$/) do
  @vault_three_key = @bob.generate_key
  @contract = @bob.fill_lock_sign_vault(@contract,
    vault_label: "[1-2-3]",
    vault_key: @vault_three_key,
    content: "Congrats!"
  )
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
