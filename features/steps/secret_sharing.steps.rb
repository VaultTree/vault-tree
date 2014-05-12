Given(/^I have a blank secret sharing contract$/) do
  contract_path = VaultTree::PathHelpers.shared_secret_contract
  @contract_json = File.read(contract_path)
  @contract = VaultTree::Contract.new(@contract_json)
end

Given(/^I create a new message$/) do
  @external_data = {"message" => "CONGRATS! YOU OPENED THE VAULT WITH AN ASSEMBLED KEY."}
end

When(/^I lock the message with an assembled key$/) do
  @contract = VaultTree::Contract.new(@contract_json, external_data: @external_data)
  @contract = @contract.close_vault('message')
end

When(/^I attempt to lock the message with a generated shamir key$/) do
  @contract = VaultTree::Contract.new(@contract_json, external_data: @external_data)
  @contract = @contract.close_vault('message')
end

Then(/^key shares are created and locked away in their cooresponding vaults$/) do
  @contract.vault_closed?('s_1').should be true
  @contract.vault_closed?('s_2').should be true
  @contract.vault_closed?('s_3').should be true
  @contract.vault_closed?('s_4').should be true
  @contract.vault_closed?('s_5').should be true
end

When(/^I attempt to unlock the message with the assembled shamir key$/) do
  @recovered_message = @contract.retrieve_contents('message')
end

Then(/^I successfully gather the locked shares and unlock the message$/) do
  puts @recovered_message
  @recovered_message.should == @external_data["message"]
end

When(/^I lock away the shamir key share collection$/) do
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('share_collection')
end

Then(/^a random key is generated and split with the shamir secret sharing algorithm$/) do
end

Then(/^I can open the vault to recover the JSON representation of the secret shares$/) do
  JSON.parse(@contract.retrieve_contents('share_collection')).should be_an_instance_of(Hash)
end
