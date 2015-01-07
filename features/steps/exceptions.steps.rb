Then(/^an exception is raised$/) do
  assert_equal true, (@exception.respond_to?(:exception) && @exception.respond_to?(:message))
end

Given(/^this broken contract:$/) do |string|
  @contract = string
end

When(/^I lock the data away$/) do
  @contract = VaultTree::Contract.new(@contract).close_vault('missing_external_data_vault')
end

When(/^I attempt fill a vault with my Master Password$/) do
  begin
    @contract = VaultTree::Contract.new(@contract).close_vault('fill_with_master_pass_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt to open an empty vault$/) do
  begin
    @contents = VaultTree::Contract.new(@contract).open_vault('empty_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt to open a vault that does not exists$/) do
  begin
    @contents = VaultTree::Contract.new(@contract).open_vault('non_existant_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt to close a vault that does not exists$/) do
  begin
    @contents = VaultTree::Contract.new(@contract).close_vault('non_existant_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt fill a vault with an unsupported Keyword$/) do
  begin
    @contract = VaultTree::Contract.new(@contract).close_vault('unsupported_keyword')
  rescue => e
    @exception = e
  end
end

When(/^I attempt to fill with an encryption key without first establishing the decryption key$/) do
  begin
    @contract = VaultTree::Contract.new(@contract).close_vault('orphaned_public_key')
  rescue => e
    @exception = e
  end
end

When(/^I lock a vault with External Input and attempt to unlock with the wrong External Input$/) do
  locking_key = VaultTree::LockSmith.new().generate_secret_key
  @contract = VaultTree::Contract.new(@contract).as_json
  @contract = VaultTree::Contract.new(@contract).close_vault('some_random_vault', right_secret: '5dd0abe3335d6f0ceab00e44a9d41a030c2a59802ffd6b42464c01f1c7fbdd68')
  @contract = VaultTree::Contract.new(@contract).as_json
  begin
    wrong_unlocking_key = VaultTree::LockSmith.new().generate_secret_key
    @contract = VaultTree::Contract.new(@contract).as_json
  @contents = VaultTree::Contract.new(@contract).open_vault('some_random_vault', wrong_secret: '7dd0abe3335d6f0ceab00e44a9d41a030c2a59802ffd6b42464c01f1c7fbdd68')
  rescue => e
    @exception = e
  end
end

When(/^I attempt lock a vault with External Input that does not exists$/) do
  @contract = VaultTree::Contract.new(@contract).as_json
  begin
    @contract = VaultTree::Contract.new(@contract).close_vault('missing_external_input_vault', empty_value: '')
  rescue => e
    @exception = e
  end
end
