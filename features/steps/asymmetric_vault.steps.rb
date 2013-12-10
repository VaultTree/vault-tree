Given(/^Alice has the blank asymmetric vault contract$/) do
  contract_path = VaultTree::PathHelpers.core_contracts('asymmetric_vault.0.1.0.json')
  @contract_json = File.read(contract_path)
end

When(/^she locks all of her public and private keys$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  @contract = @contract.close_vault('alice_contract_secret')
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob over the internet$/) do
  @contract_json = @contract.as_json
  @bobs_external_data = {"message" => "CONGRATS ALICE! YOU UNLOCKED THE SECRET MESSAGE WITH A SHARED KEY."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'BOB_SECURE_PASS', external_data: @bobs_external_data)
end

Then(/^Bob can access of her public keys but not her private keys$/) do
  @contents = @contract.retrieve_contents('alice_public_encryption_key')
end

When(/^Bob locks his public and private keys$/) do
  @contract = @contract.close_vault('bob_decryption_key')
  @contract = @contract.close_vault('bob_public_encryption_key')
end

When(/^He fills and locks the vault containing the message using a SHARED_KEY$/) do
  @contract = @contract.close_vault('message')
end


When(/^he sends the contract back to Alice over the internet$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
end

Then(/^Alice can unlock the message with a SHARED_KEY$/) do
  puts @contract.retrieve_contents('message')
  @contract.retrieve_contents('message').should == @bobs_external_data['message']
end
