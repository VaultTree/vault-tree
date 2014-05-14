Given(/^a valid blank contract$/) do
  contract_path = VaultTree::PathHelpers.reference_contract
  @contract_json = File.read(contract_path)
end

Then(/^a MissingPassphrase exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingPassphrase)
end

Given(/^this broken contract:$/) do |string|
  @contract_json = string
  @contract = VaultTree::Contract.new(@contract_json, external_data: {})
end

Given(/^the broken contract$/) do
  contract_path = VaultTree::PathHelpers.broken_contract
  @contract_json = File.read(contract_path)
  @contract = VaultTree::Contract.new(@contract_json, external_data: {})
end

When(/^I attempt lock a vault with External Data that does not exists$/) do
  @contract = VaultTree::Contract.new(@contract_json, external_data: nil )
  begin
    @contract = @contract.close_vault('missing_external_data_vault')
  rescue => e
    @exception = e
  end
end

When(/^I lock the data away$/) do
  @contract = VaultTree::Contract.new(@contract_json).close_vault('missing_external_data_vault')
end

When(/^I attempt to unlock a vault with External Data that does not exists$/) do
  begin
    @contract = @contract.retrieve_contents('missing_external_data_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt fill a vault with External Data that does not exists$/) do
  begin
    @contract = @contract.close_vault('missing_external_data_vault')
  rescue => e
    @exception = e
  end
end

Then(/^a MissingExternalData exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingExternalData)
end

When(/^I attempt fill a vault with my Master Password$/) do
  begin
    @contract = @contract.close_vault('fill_with_master_pass_vault')
  rescue => e
    @exception = e
  end
end

Then(/^a FillAttemptMasterPassword exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::FillAttemptMasterPassword)
end

When(/^I attempt to open an empty vault$/) do
  begin
    @contents = @contract.retrieve_contents('empty_vault')
  rescue => e
    @exception = e
  end
end

Then(/^an EmptyVault exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::EmptyVault)
end

When(/^I attempt to open a vault that does not exists$/) do
  begin
    @contents = @contract.retrieve_contents('non_existant_vault')
  rescue => e
    @exception = e
  end
end

When(/^I attempt to close a vault that does not exists$/) do
  begin
    @contents = @contract.close_vault('non_existant_vault')
  rescue => e
    @exception = e
  end
end

Then(/^a VaultDoesNotExist exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::VaultDoesNotExist)
end

When(/^I attempt fill a vault with an unsupported Keyword$/) do
  begin
    @contract = @contract.close_vault('unsupported_keyword')
  rescue => e
    @exception = e
  end
end

Then(/^an UnsupportedKeyword exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::UnsupportedKeyword)
end

When(/^I attempt to fill with an encryption key without first establishing the decryption key$/) do
  begin
    @contract = @contract.close_vault('orphaned_public_key')
  rescue => e
    @exception = e
  end
end

Then(/^a MissingPartnerDecryptionKey exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingPartnerDecryptionKey)
end

When(/^I lock a vault with External Input and attempt to unlock with the wrong External Input$/) do
  locking_key = VaultTree::LockSmith.new().generate_secret_key
  @contract = VaultTree::Contract.new(@contract_json)
  @contract = @contract.close_vault('some_random_vault', right_secret: 'LOCK_WITH_ME')
  @contract_json = @contract.as_json
  begin
    wrong_unlocking_key = VaultTree::LockSmith.new().generate_secret_key
    @contract = VaultTree::Contract.new(@contract_json)
    @contents = @contract.retrieve_contents('some_random_vault', wrong_secret: 'DO_NOT_UNLOCK_WITH_ME')
  rescue => e
    @exception = e
  end
end

Then(/^a FailedUnlockAttempt exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::FailedUnlockAttempt)
end

When(/^I attempt lock a vault with External Input that does not exists$/) do
  @contract = VaultTree::Contract.new(@contract_json)
  begin
    @contract = @contract.close_vault('missing_external_input_vault', empty_value: '')
  rescue => e
    @exception = e
  end
end

Then(/^an InvalidExternalInput exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::InvalidExternalInput)
end
