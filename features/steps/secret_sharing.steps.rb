Given(/^I have a blank secret sharing contract$/) do
  contract_path = VaultTree::PathHelpers.shared_secret_contract
  @contract_json = File.read(contract_path)
  @contract = VaultTree::Contract.new(@contract_json)
end

Then(/^key shares are created and locked away in their cooresponding vaults$/) do
  @contract.vault_closed?('s_1').should be true
  @contract.vault_closed?('s_2').should be true
  @contract.vault_closed?('s_3').should be true
  @contract.vault_closed?('s_4').should be true
  @contract.vault_closed?('s_5').should be true
end

When(/^I lock away the shamir key share collection$/) do
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('share_collection')
end

Then(/^a random key is generated and split with the shamir secret sharing algorithm$/) do
end

Then(/^I can open the vault to recover the JSON representation of the secret shares$/) do
  JSON.parse(@contract.open_vault('share_collection')).should be_an_instance_of(Hash)
end

When(/^I fill an individual vault with the SECRET_SHARES keyword$/) do
  @contract = @contract.close_vault('share_1')
  @contract = @contract.close_vault('share_2')
  @contract = @contract.close_vault('share_3')
end

Then(/^the library takes the approprate share from the collection vault and locks it away$/) do
  @contract.vault_closed?('share_1').should be true
  @contract.vault_closed?('share_2').should be true
  @contract.vault_closed?('share_3').should be true
end

When(/^I close the key shares in their respective vaults$/) do
  @contract = @contract.close_vault('s_1')
  @contract = @contract.close_vault('s_2')
  @contract = @contract.close_vault('s_3')
  @contract = @contract.close_vault('s_4')
  @contract = @contract.close_vault('s_5')
end

Then(/^I can lock away a message with the key assembled from the shares$/) do
  @message = 'MY SECRET STRING!'
  @contract = @contract.close_vault('message', msg: @message)
end

Then(/^if all the shares are available I can unlock the message$/) do
  @contract.open_vault('message').should == @message
end
