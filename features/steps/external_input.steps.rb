When(/^I lock the external input in a vault using a symmetric vault key$/) do
  @secret = "#{VaultTree::LockSmith.new(message: 'secret_string').secure_hash}"
  @contract = VaultTree::Contract.new(@contract).as_json
  @external_input = {msg: 'You Opened the Vault!', secret: @secret}
  @contract = VaultTree::Contract.new(@contract).close_vault('message', @external_input)
end

Then(/^I can recover the input message using the same key$/) do
  assert_equal @external_input[:msg], VaultTree::Contract.new(@contract).open_vault('message', secret: @secret)
end

When(/^I lock the external input in a vault using an external key$/) do
  @secret = "MY SECRET KEY THAT IS NOT THE PROPER NUMBER OF BYTES"
  @contract = VaultTree::Contract.new(@contract).as_json
  @external_input = {msg: 'You Opened the Vault!', secret: @secret}
  @contract = VaultTree::Contract.new(@contract).close_vault('message', @external_input)
end
