When(/^Alice locks all of her public and private keys$/) do
  @acs_key = "#{VaultTree::LockSmith.new(message: 'ALICE_SECURE_PASS').secure_hash}"
  @contract = VaultTree::Contract.new(@contract).close_vault('alice_contract_secret', acs_key: @acs_key)
  @contract = VaultTree::Contract.new(@contract).close_vault('alice_decryption_key', acs_key: @acs_key)
  @contract = VaultTree::Contract.new(@contract).close_vault('alice_public_encryption_key', acs_key: @acs_key)
end

When(/^she sends the contract to Bob over the internet$/) do
  @bcs_key = "#{VaultTree::LockSmith.new(message: 'BOB_SECURE_PASS').secure_hash}"
end

Then(/^Bob can access of her public keys but not her private keys$/) do
  @contents = VaultTree::Contract.new(@contract).open_vault('alice_public_encryption_key')
end

When(/^Bob locks his public and private keys$/) do
  @contract = VaultTree::Contract.new(@contract).close_vault('bob_decryption_key', bcs_key: @bcs_key)
  @contract = VaultTree::Contract.new(@contract).close_vault('bob_public_encryption_key', bcs_key: @bcs_key)
end

When(/^He fills and locks the vault containing the message using a DH_KEY$/) do
  @msg = "CONGRATS ALICE! YOU UNLOCKED THE SECRET MESSAGE WITH A DH KEY."
  @contract = VaultTree::Contract.new(@contract).close_vault('message', msg: @msg, bcs_key: @bcs_key)
end


When(/^he sends the contract back to Alice over the internet$/) do
  @contract = VaultTree::Contract.new(@contract).as_json
end

Then(/^Alice can unlock the message with a DH_KEY$/) do
  puts VaultTree::Contract.new(@contract).open_vault('message', acs_key: @acs_key)
  VaultTree::Contract.new(@contract).open_vault('message', acs_key: @acs_key).should == @msg
end
