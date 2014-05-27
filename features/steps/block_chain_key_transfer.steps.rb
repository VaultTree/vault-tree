Given(/^the SENDER has the blank contract template$/) do
end

Given(/^the SENDER chooses an origin address and a concealed destination address$/) do
  @sender_secret = "#{VaultTree::LockSmith.new(message: 'SENDER_SECURE_PASS').secure_hash}"
  @sender_origin_wallet_address = '1XJEBF8EUBF855NEBHVENPFE9JE74E'
  @sender_concealed_destination_wallet_address = '1JVKE8HD5JDHFEJHF678JEH8DEJGHE'
  @sender_btc_signing_key = 'BITCOIN_SIGNING_KEY_KEEP_IT_SECRET'

  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('sender_concealed_destination_wallet_address', scdwa: @sender_concealed_destination_wallet_address, ss_key: @sender_secret)
  @contract = @contract.close_vault('sender_origin_wallet_address', sowa: @sender_origin_wallet_address, ss_key: @sender_secret)
end

Given(/^he locks away the secret BTC signing key$/) do
  @contract = @contract.close_vault('sender_btc_signing_key', ssk: @sender_btc_signing_key, ss_key: @sender_secret)
end

When(/^the SENDER transfers the contract to the RECEIVER$/) do
  @contract_json_over_the_wire = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json_over_the_wire)
end

Then(/^the RECEIVER can access the origin wallet address$/) do
  @receiver_secret = "#{VaultTree::LockSmith.new(message: 'RECEIVER_SECURE_PASS').secure_hash}"
  @contract.open_vault('sender_origin_wallet_address', rs_key: @receiver_secret).should == @sender_origin_wallet_address
end

When(/^the SENDER reveals the hidden wallet address by transfering bitcoins from the origin address$/) do
  @contract_json = @contract.as_json # save the json state
  wallet_address_from_watching_blockchain = @sender_concealed_destination_wallet_address # This is made public on the chain
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('receiver_revealed_destination_wallet_address', rs_key: @receiver_secret, rrdwa: wallet_address_from_watching_blockchain)
end

Then(/^the RECEIVER can unlock the vault to recover the transfered signing key$/) do
  transfered_secret_key = @contract.open_vault('sender_btc_signing_key', rs_key: @receiver_secret)
  transfered_secret_key.should ==  @sender_btc_signing_key
  puts "PROPERLY TRANSFERED: #{transfered_secret_key} !"
end
