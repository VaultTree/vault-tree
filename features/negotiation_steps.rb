Then(/^Alice can validate his signatures$/) do
  @alice.verify_signatures(@contract, 'bob').should be true
end

Then(/^Bob can validate her signatures$/) do
  @bob.verify_signatures(@contract, 'alice').should be true
end

Given(/^Bob is ready to FLS each vault$/) do
  step "Bob has the contract with Alices signed public attributes"
  step "he writes his public and private attributes"
  step "he signs his public attributes"
end

When(/^Bob FLS each vault$/) do
  raise 'IN THE PROCESS OF IMPLEMENTING'
  @contract = @bob.fill_vaults(@contract)
  @contract = @bob.lock_vaults(@contract)
  @contract = @bob.sign_vaults(@contract)
end

Then(/^the contract is ready to be executed$/) do
  @bob.ready_to_execute?(@contract).should be true
end

When(/^she sanitizes the contract$/) do
  @contract = @alice.sanitize_contract(@contract)
end

When(/^he sanitizes the contract$/) do
  @contract = @bob.sanitize_contract(@contract)
end

Given(/^Bob has the contract with Alices signed public attributes$/) do
  step "Alice has a version two blank contract"
  step "she writes her public attributes"
  step "she writes her private attributes"
  step "she signs her public attributes"
  step "she sanitizes the contract"
  step "she can send the contract to Bob"
end

When(/^he writes his public and private attributes$/) do
  @contract = @bob.write_public_attributes(@contract)
  @contract = @bob.write_private_attributes(@contract)
end

When(/^he signs his public attributes$/) do
  @contract = @bob.sign_public_attributes(@contract)
end

Given(/^Alice has a version two blank contract$/) do
  @contract = File.open(VaultTree::PathHelpers.one_two_three_020).read
  @alice = VaultTree::AutoBots::Alice.new()
end

When(/^she writes her public attributes$/) do
  @contract = @alice.write_public_attributes(@contract)
end

When(/^she writes her private attributes$/) do
  @contract = @alice.write_private_attributes(@contract)
end

When(/^she signs her public attributes$/) do
  @contract = @alice.sign_public_attributes(@contract)
end

Then(/^she can send the contract to Bob$/) do
  @bob = VaultTree::AutoBots::Bob.new()
end

Given(/^Alice has the blank contract$/) do
  @contract = File.open(VaultTree::PathHelpers.one_two_three_contract).read
  @alice = VaultTree::AutoBots::Alice.new()
end

When(/^she writes and signs her public attributes$/) do
  @contract = @alice.write_public_attrs(@contract)
  @contract = @alice.sign_public_attrs(@contract)
end

When(/^she sends the contract to Bob$/) do
  @bob = VaultTree::AutoBots::Bob.new()
end

Then(/^Bob can validate her public attributes$/) do
  pending 'NON YET IMPLEMENTED'
  @contract = @bob.validate_public_attrs(@contract, party_label: "alice")
end

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
  @vault_two_key = @bob.generate_key
  @contract = @bob.fill_lock_sign_vault(@contract,
    vault_label: "[1-2]",
    vault_key: @vault_two_key,
    content: @vault_three_key
  )
end

When(/^Bob FLS the first vault$/) do
  pending 'LOCK THE FIRST VAULT WITH ALICES PUBLIC KEY'
  @alice_pek = 'ALICE PUBLIC ENCRYPTION KEY'
  @contract = @bob.fill_lock_sign_vault(@contract,
    vault_label: "[1-2]",
    vault_key: @vault_one_key,
    content: @vault_two_key
  )
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
