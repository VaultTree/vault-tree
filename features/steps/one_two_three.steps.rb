Given(/^Alice has the blank contract$/) do
end

# Change this to just attributes vice public attributes
When(/^she locks all of her attributes$/) do
  @alice_contract_secret_key = "#{VaultTree::LockSmith.new(message: 'ALICE_SECURE_PASS').secure_hash}"
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('alice_decryption_key', acs_key: @alice_contract_secret_key)
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @bob_contract_secret_key = "#{VaultTree::LockSmith.new(message: 'BOB_SECURE_PASS').secure_hash}"
  @congratulations_message = "CONGRATS! YOU OPENED THE THIRD VAULT."
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json)
end

Then(/^Bob can access all of her public attributes$/) do
  @contents = @contract.retrieve_contents('alice_public_encryption_key')
end

When(/^Bob locks his attributes$/) do

  @contract = @contract.close_vault('bob_decryption_key', bcs_key: @bob_contract_secret_key)
  # Verify can reopen
  @contract.retrieve_contents('bob_decryption_key', bcs_key: @bob_contract_secret_key)

  @contract = @contract.close_vault('congratulations_message', bcs_key: @bob_contract_secret_key, msg: @congratulations_message)
  # Verify can reopen
  @contract.retrieve_contents('congratulations_message', bcs_key: @bob_contract_secret_key)

  @contract = @contract.close_vault('vault_two_key', bcs_key: @bob_contract_secret_key)
  # Verify they can reopen
  @contract.retrieve_contents('vault_two_key', bcs_key: @bob_contract_secret_key)

  @contract = @contract.close_vault('vault_three_key', bcs_key: @bob_contract_secret_key)
  # Verify they can reopen
  @contract.retrieve_contents('vault_three_key', bcs_key: @bob_contract_secret_key)

  @contract = @contract.close_vault('bob_public_encryption_key')
  # Verify they can reopen
  @contract.retrieve_contents('bob_public_encryption_key')
end

When(/^He fills and locks each of the three main vaults$/) do
  @contract = @contract.close_vault('first', bcs_key: @bob_contract_secret_key)
  @contract = @contract.close_vault('second', bcs_key: @bob_contract_secret_key)
  @contract = @contract.close_vault('third', bcs_key: @bob_contract_secret_key)
end

Then(/^Alice can execute the contract to recover the final message$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json)
  puts @contract.retrieve_contents('third', acs_key: @alice_contract_secret_key)
  @contract.retrieve_contents('third', acs_key: @alice_contract_secret_key).should == @congratulations_message
end
