Given(/^Alice has the blank contract$/) do
  contract_path = VaultTree::PathHelpers.reference_contract
  @contract_json = File.read(contract_path)
end

# Change this to just attributes vice public attributes
When(/^she locks all of her attributes$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob$/) do
  @contract_json = @contract.as_json 
  @bobs_external_data = {"congratulations_message" => "CONGRATS! YOU OPENED THE THIRD VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'BOB_SECURE_PASS', external_data: @bobs_external_data)
end

Then(/^Bob can access her public attributes$/) do
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

When(/^He fills and locks each of the three vaults$/) do
  @contract = @contract.close_vault('first')
  @contract = @contract.close_vault('second')
  @contract = @contract.close_vault('third')
end

Then(/^Alice can execute the contract to recover the final message$/) do
  @contract_json = @contract.as_json 
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ALICE_SECURE_PASS', external_data: {})
  puts @contract.retrieve_contents('third')
  @contract.retrieve_contents('third').should == @bobs_external_data['congratulations_message']
end

Given(/^the SENDER has the blank BTC Key Transfer template$/) do
  contract_path = VaultTree::PathHelpers.reference_contract
  @contract_json = File.read(contract_path)
end

Given(/^the SENDER chooses an origin wallet address and concealed destination address$/) do
  @sender_external_data =
    {
      'sender_origin_wallet_address' => '1XJEBF8EUBF855NEBHVENPFE9JE74E',
      'sender_concealed_destination_wallet_address' => '1JVKE8HD5JDHFEJHF678JEH8DEJGHE',
      'sender_btc_signing_key' => 'BITCOIN_SIGNING_KEY_KEEP_IT_SECRET'
    }
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'SENDER_SECURE_PASS', external_data: @sender_external_data)
  @contract = @contract.close_vault('sender_origin_wallet_address')
  @contract = @contract.close_vault('sender_concealed_destination_wallet_address')
end

Given(/^he locks away the secret BTC signing key$/) do
  @contract = @contract.close_vault('sender_btc_signing_key')
end

When(/^the SENDER transfers the Vault\-Tree contract to the RECEIVER$/) do
  @contract_json_over_the_wire = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json_over_the_wire, master_passphrase: 'RECEIVER_SECURE_PASS')
end

Then(/^the RECEIVER can access the origin wallet address$/) do
  @contract.retrieve_contents('sender_origin_wallet_address').should == @sender_external_data['sender_origin_wallet_address']
end

When(/^the SENDER reveals the hidden wallet address by Blockchain payment from the origin address$/) do
  @contract_json = @contract.as_json # save the json state
  wallet_address_from_watching_blockchain = @sender_external_data['sender_concealed_destination_wallet_address']
  @receiver_external_data = { 'receiver_revealed_destination_wallet_address' => wallet_address_from_watching_blockchain}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'RECEIVER_SECURE_PASS', external_data: @receiver_external_data)
  @contract = @contract.close_vault('receiver_revealed_destination_wallet_address')
end

Then(/^the RECEIVER can unlock the vault to recover the transfered signing key$/) do
  transfered_secret_key = @contract.retrieve_contents('sender_btc_signing_key')
  transfered_secret_key.should ==  @sender_external_data['sender_btc_signing_key']
  puts "PROPERLY TRANSFERED: #{transfered_secret_key} !"
end
