Given(/^a valid blank contract$/) do
  @contract_json = FactoryGirl.build(:blank_one_two_three).as_json
end

When(/^I attempt fill a vault without providing a master passphrase$/) do
  begin
    @contract = VaultTree::Contract.new(@contract_json)
    @contract = @contract.close_vault_path('alice_contract_secret')
  rescue => e
    @exception = e
  end
end

Then(/^a MissingPassphrase exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingPassphrase)
end

Given(/^the broken contract$/) do
  @contract_json = FactoryGirl.build(:broken_contract).as_json
  @contract = VaultTree::Contract.new(@contract_json, master_passphrase: 'TEST_USER', external_data: {})
end

When(/^I attempt fill a vault with External Data that does not exists$/) do
  begin
    @contract = @contract.close_vault_path('missing_external_data_vault')
  rescue => e
    @exception = e
  end
end

Then(/^a MissingExternalData exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingExternalData)
end

When(/^I attempt fill a vault with my Master Password$/) do
  begin
    @contract = @contract.close_vault_path('fill_with_master_pass_vault')
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

Then(/^a VaultDoesNotExist exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::VaultDoesNotExist)
end

When(/^I attempt fill a vault with an unsupported Keyword$/) do
  begin
    @contract = @contract.close_vault_path('unsupported_keyword')
  rescue => e
    @exception = e
  end
end

Then(/^an UnsupportedKeyword exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::UnsupportedKeyword)
end

Given(/^not yet implemented$/) do
  pending 'Scenario is TBD' 
end
