When(/^I lock the external input in a vault using a symmetric vault key$/) do
  @secret = "#{VaultTree::LockSmith.new(message: 'secret_string').secure_hash}"
  @contract = VaultTree::Contract.new(@contract_json)
  @external_input = {msg: 'You Opened the Vault!', secret: @secret}
  @contract = @contract.close_vault('message', @external_input)
end

Then(/^I can recover the input message using the same key$/) do
  @contract.retrieve_contents('message', secret: @secret).should == @external_input[:msg]
end
