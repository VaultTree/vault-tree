Given(/^Alice has the blank contract$/) do
  @alice = VaultTree::V3::User.new(user_id: 'alice', master_passphrase: 'ALICE_SECURE_PASS', shared_contract_secret: 'ALICE_AND_BOB')
  @contract = FactoryGirl.build(:blank_one_two_three)
  @interpreter = VaultTree::V3::Interpreter.new
end

When(/^she locks all of her public attributes$/) do
  @contract = @interpreter.close_vault_path(vault_id: 'alice_public_encryption_key', contract: @contract, user: @alice)
  @contract = @interpreter.close_vault_path(vault_id: 'alice_decryption_key', contract: @contract, user: @alice)
end

When(/^she sends the contract to Bob$/) do
  @bobs_messages = {"congratulations" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @bob = VaultTree::V3::User.new(user_id: 'bob', master_passphrase: 'BOB_SECURE_PASS', shared_contract_secret: 'ALICE_AND_BOB', messages: @bobs_messages)
end

Then(/^Bob can access all of her public attributes$/) do
  @contents = @interpreter.retrieve_contents(vault_id: 'alice_public_encryption_key', contract: @contract, user: @bob)
  @contents.should == @alice.public_encryption_key
end

When(/^Bob locks his public attributes$/) do
  @contract = @interpreter.close_vault_path(vault_id: 'bob_shared_contract_secret', contract: @contract, user: @bob)
  @contract = @interpreter.close_vault_path(vault_id: 'bob_decryption_key', contract: @contract, user: @bob)
  @contract = @interpreter.close_vault_path(vault_id: 'congratulations_message', contract: @contract, user: @bob)
  @contract = @interpreter.close_vault_path(vault_id: 'vault_two_key', contract: @contract, user: @bob)
  @contract = @interpreter.close_vault_path(vault_id: 'vault_three_key', contract: @contract, user: @bob)
end

When(/^He fills and locks each of the three vaults$/) do
  pending
  @contract = @interpreter.close_vault_path(vault_id: 'first', contract: @contract, user: @bob)
end

Then(/^Alice can execute the contract to recover the final message$/) do
  pending # express the regexp above with the code you wish you had
end
