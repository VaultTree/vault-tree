When(/^I lock the external input in a vault using a symmetric vault key$/) do
  @contract = VaultTree::Contract.new(@contract_json)
  @external_input = {msg: 'You Opened the Vault!'}
  @contract = @contract.close_vault('message', @external_input)
end

Then(/^I can recover the input message using the same key$/) do
  @contract.retrieve_contents('message').should == @external_input[:msg]
end
