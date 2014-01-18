Given(/^a valid blank contract$/) do
  contract_path = VaultTree::PathHelpers.reference_contract
  @contract_json = File.read(contract_path)
end

When(/^I attempt fill a vault without providing a master passphrase$/) do
  begin
    @contract = VaultTree::Contract.new(@contract_json)
    @contract = @contract.close_vault('message')
  rescue => e
    @exception = e
  end
end

Then(/^a MissingPassphrase exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingPassphrase)
end

Given(/^this broken contract:$/) do |string|
  @contract_json = string
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'TEST_USER', external_data: {})
end

Given(/^the broken contract$/) do
  contract_path = VaultTree::PathHelpers.broken_contract
  @contract_json = File.read(contract_path)
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'TEST_USER', external_data: {})
end

When(/^I attempt lock a vault with External Data that does not exists$/) do
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'TEST_USER', external_data: nil )
  begin
    @contract = @contract.close_vault('missing_external_data_vault')
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
