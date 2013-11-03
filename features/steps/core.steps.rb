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

Given(/^I have a blank reference contract$/) do
  contract_path = VaultTree::PathHelpers.reference_contract
  @contract_json = File.read(contract_path)
end

When(/^I lock a message in a vault with my Master Password$/) do
  @external_data = {"message" => "CONGRATS! YOU OPENED THE VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS', external_data: @external_data)
  @contract = @contract.close_vault('message')
end

Then(/^I can recover the message with my Master Password$/) do
  @contract.retrieve_contents('message').should == @external_data['message']
end

When(/^I lock away a random vault key$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS')
  @contract = @contract.close_vault('random_vault_key')
end

When(/^I use the random key to lock a message$/) do
  @external_data = {"message_locked_with_random" => "CONGRATS! YOU OPENED THE VAULT WITH A RANDOM KEY."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS', external_data: @external_data)
  @contract = @contract.close_vault('message_locked_with_random')
end

Then(/^I can recover the message with the Random Key$/) do
  @contract.retrieve_contents('message_locked_with_random').should == @external_data['message_locked_with_random']
end

When(/^I put this random key in an unlocked vault$/) do
  @contract = @contract.close_vault('unlocked_random_key')
end

Then(/^another user can recover the message with the Unlocked Random Key$/) do
  @contract = @contract.close_vault('message_locked_with_unlocked_random_number')
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ANOTHER_SECURE_PASS')
  @contract.retrieve_contents('message_locked_with_unlocked_random_number').should == @external_data['message_locked_with_random']
end

Given(/^I have access to the another user's unlocked public key$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ANOTHER_USERS_SECURE_PASS')
  @contract = @contract.close_vault('another_decryption_key')
  @contract = @contract.close_vault('another_public_key')
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS')
  @contract = @contract.close_vault('my_decryption_key')
  @contract = @contract.close_vault('my_public_key')
end

Given(/^I lock a simple message with a shared key$/) do
  @contract_json = @contract.as_json
  @external_data = {"asymmetric_message" => "CONGRATS! YOU OPENED THE ASYMMETRIC VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS', external_data: @external_data)
  @contract = @contract.close_vault('asymmetric_message')
end

When(/^I transfer the contract to the other user$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ANOTHER_USERS_SECURE_PASS')
end

Then(/^they can create a shared key and unlock the message$/) do
  @contract.retrieve_contents('asymmetric_message').should == @external_data['asymmetric_message']
end
