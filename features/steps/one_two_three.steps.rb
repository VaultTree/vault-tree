Given(/^Alice has the blank contract$/) do
  contract_path = VaultTree::PathHelpers.core_contracts('one_two_three.0.7.0.json')
  @contract_json = File.read(contract_path)
end

# Change this to just attributes vice public attributes
When(/^she locks all of her attributes$/) do
  @alice_contract_secret = "#{VaultTree::LockSmith.new(message: 'ALICE_SECURE_PASS').secure_hash}"
  @contract = VaultTree::Contract.new(@contract_json,
                                      external_data: {"alice_contract_secret" => @alice_contract_secret}
                                     )
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @bob_contract_secret = "#{VaultTree::LockSmith.new(message: 'BOB_SECURE_PASS').secure_hash}"
  @contract_json = @contract.as_json 
  @bobs_external_data = { "bob_contract_secret" => @bob_contract_secret, "congratulations_message" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, external_data: @bobs_external_data)
end

Then(/^Bob can access all of her public attributes$/) do
  @contents = @contract.retrieve_contents('alice_public_encryption_key')
end

When(/^Bob locks his attributes$/) do

  @contract = @contract.close_vault('bob_decryption_key')
  # Verify can reopen
  @contract.retrieve_contents('bob_decryption_key')

  @contract = @contract.close_vault('congratulations_message')
  # Verify can reopen
  @contract.retrieve_contents('congratulations_message')

  @contract = @contract.close_vault('vault_two_key')
  # Verify they can reopen
  @contract.retrieve_contents('vault_two_key')

  @contract = @contract.close_vault('vault_three_key')
  # Verify they can reopen
  @contract.retrieve_contents('vault_three_key')

  @contract = @contract.close_vault('bob_public_encryption_key')
  # Verify they can reopen
  @contract.retrieve_contents('bob_public_encryption_key')
end

When(/^He fills and locks each of the three main vaults$/) do
  @contract = @contract.close_vault('first')
  @contract = @contract.close_vault('second')
  @contract = @contract.close_vault('third')
end

Then(/^Alice can execute the contract to recover the final message$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, external_data: {"alice_contract_secret" => @alice_contract_secret})
  puts @contract.retrieve_contents('third')
  @contract.retrieve_contents('third').should == @bobs_external_data['congratulations_message']
end
