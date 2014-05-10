Given(/^Alice has the blank asymmetric vault contract$/) do
  contract_path = VaultTree::PathHelpers.core_contracts('asymmetric_vault.0.1.0.json')
  @contract_json = File.read(contract_path)
end

When(/^Alice locks all of her public and private keys$/) do
  @alice_contract_secret = "#{VaultTree::LockSmith.new(message: 'ALICE_SECURE_PASS').secure_hash}"
  @contract = VaultTree::Contract.new(@contract_json,
                                      external_data: {"alice_contract_secret" => @alice_contract_secret}
                                     )
  @contract = @contract.close_vault('alice_contract_secret')
  @contract = @contract.close_vault('alice_decryption_key')
  @contract = @contract.close_vault('alice_public_encryption_key')
end

When(/^she sends the contract to Bob over the internet$/) do
  @bob_contract_secret = "#{VaultTree::LockSmith.new(message: 'BOB_SECURE_PASS').secure_hash}"
  @contract_json = @contract.as_json
  @bobs_external_data = {"bob_contract_secret" => @bob_contract_secret,"message" => "CONGRATS ALICE! YOU UNLOCKED THE SECRET MESSAGE WITH A DH KEY."}
  @contract = VaultTree::Contract.new(@contract_json, external_data: @bobs_external_data)
end

Then(/^Bob can access of her public keys but not her private keys$/) do
  @contents = @contract.retrieve_contents('alice_public_encryption_key')
end

When(/^Bob locks his public and private keys$/) do
  @contract = @contract.close_vault('bob_decryption_key')
  @contract = @contract.close_vault('bob_public_encryption_key')
end

When(/^He fills and locks the vault containing the message using a DH_KEY$/) do
  @contract = @contract.close_vault('message')
end


When(/^he sends the contract back to Alice over the internet$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, external_data: {"alice_contract_secret" => @alice_contract_secret})
end

Then(/^Alice can unlock the message with a DH_KEY$/) do
  puts @contract.retrieve_contents('message')
  @contract.retrieve_contents('message').should == @bobs_external_data['message']
end
