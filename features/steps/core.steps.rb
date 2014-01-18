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

Given(/^I lock a simple message with a DH Key$/) do
  @contract_json = @contract.as_json
  @external_data = {"asymmetric_message" => "CONGRATS! YOU OPENED THE ASYMMETRIC VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS', external_data: @external_data)
  @contract = @contract.close_vault('asymmetric_message')
end

When(/^I transfer the contract to the other user$/) do
  @contract_json = @contract.as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'ANOTHER_USERS_SECURE_PASS')
end

Then(/^they can create a DH Key and unlock the message$/) do
  @contract.retrieve_contents('asymmetric_message').should == @external_data['asymmetric_message']
end

Given(/^Consent keys for parties A, B, and C$/) do
  @locking_consent_keys = {
    "a_consent_key" => "A_SECRET_CONSENT_KEY",
    "b_consent_key" => "B_SECRET_CONSENT_KEY",
    "c_consent_key" => "C_SECRET_CONSENT_KEY"
  }
end

When(/^I lock a message in a vault using a split key$/) do
  @message = {"abc_consent_message" => "A, B, AND C ALL AGREED TO OPEN THE VAULT." }
  @external_data = @locking_consent_keys.merge(@message)
  @contract = VaultTree::Contract.new(@contract_json, external_data: @external_data)
  @contract = @contract.close_vault('a_consent_key')
  @contract = @contract.close_vault('b_consent_key')
  @contract = @contract.close_vault('c_consent_key')
  @contract = @contract.close_vault('abc_joint_consent_key')
  @contract = @contract.close_vault('abc_consent_message')
  @contract_json = @contract.as_json
end

Then(/^I can recover the message if each party gives consent$/) do
  @unlocking_consent_keys = {
    "a_consent_key" => "A_SECRET_CONSENT_KEY",
    "b_consent_key" => "B_SECRET_CONSENT_KEY",
    "c_consent_key" => "C_SECRET_CONSENT_KEY"
  }
  @contract = VaultTree::Contract.new(@contract_json, external_data: @unlocking_consent_keys)
  @contract.retrieve_contents('abc_consent_message').should == @external_data['abc_consent_message']
  puts @contract.retrieve_contents('abc_consent_message')
end

Then(/^I cannot recover the message if one party fails to give consent$/) do
  @incomplete_unlocking_consent_keys = {
    "a_consent_key" => "A_WRONG_SECRET_CONSENT_KEY",
    "b_consent_key" => "B_SECRET_CONSENT_KEY",
    "c_consent_key" => "C_SECRET_CONSENT_KEY"
  }
  @contract = VaultTree::Contract.new(@contract_json, external_data: @incomplete_unlocking_consent_keys)
  expect{@contract.retrieve_contents('abc_consent_message')}.to raise_error(VaultTree::Exceptions::FailedUnlockAttempt)
end

Given(/^the blank contract:$/) do |string|
  @contract_json = string
end

When(/^I lock a message in a vault using a symmetric vault key$/) do
  @external_data = {"message" => "CONGRATS! YOU OPENED THE VAULT."}
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'MY_SECURE_PASS', external_data: @external_data)
  @contract = @contract.close_vault('message')
end

Then(/^I can recover the message using the same key$/) do
  @contract.retrieve_contents('message').should == @external_data['message']
end
