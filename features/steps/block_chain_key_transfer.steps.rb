Given(/^the SENDER has the blank contract template$/) do
  contract_path = VaultTree::PathHelpers.core_contracts('block_chain_key_transfer.0.1.0.json')
  @contract_json = File.read(contract_path)
end

Given(/^the SENDER chooses an origin address and a concealed destination address$/) do
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

When(/^the SENDER transfers the contract to the RECEIVER$/) do
  @contract_json_over_the_wire = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json_over_the_wire, master_passphrase: 'RECEIVER_SECURE_PASS')
end

Then(/^the RECEIVER can access the origin wallet address$/) do
  @contract.retrieve_contents('sender_origin_wallet_address').should == @sender_external_data['sender_origin_wallet_address']
end

When(/^the SENDER reveals the hidden wallet address by transfering bitcoins from the origin address$/) do
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
