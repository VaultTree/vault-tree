Given(/^Alice has the blank contract$/) do
  @contract_json = FactoryGirl.build(:blank_one_two_three).as_json
end


# Change this to just attributes vice public attributes
When(/^she locks all of her public attributes$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  @contract = @contract.close_vault_path('alice_decryption_key')
  @contract = @contract.close_vault_path('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @contract_json = @contract.as_json 
  @bobs_external_data = {"congratulations_message" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'BOB_SECURE_PASS', external_data: @bobs_external_data)
end

Then(/^Bob can access all of her public attributes$/) do
  @contents = @contract.retrieve_contents('alice_public_encryption_key')
end

When(/^Bob locks his public attributes$/) do

  @contract = @contract.close_vault_path('bob_decryption_key')
  # Verify can reopen
  @contract.retrieve_contents('bob_decryption_key')

  @contract = @contract.close_vault_path('congratulations_message')
  # Verify can reopen
  @contract.retrieve_contents('congratulations_message')

  @contract = @contract.close_vault_path('vault_two_key')
  # Verify they can reopen
  @contract.retrieve_contents('vault_two_key')

  @contract = @contract.close_vault_path('vault_three_key')
  # Verify they can reopen
  @contract.retrieve_contents('vault_three_key')

  @contract = @contract.close_vault_path('bob_public_encryption_key')
  # Verify they can reopen
  @contract.retrieve_contents('bob_public_encryption_key')
end

When(/^He fills and locks each of the three vaults$/) do
  @contract = @contract.close_vault_path('first')
  @contract = @contract.close_vault_path('second')
  @contract = @contract.close_vault_path('third')
end

Then(/^Alice can execute the contract to recover the final message$/) do
  @contract_json = @contract.as_json 
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  puts @contract.retrieve_contents('third')
  @contract.retrieve_contents('third').should == @bobs_external_data['congratulations_message']
end
