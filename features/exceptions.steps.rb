Given(/^a valid blank contract$/) do
  @contract = FactoryGirl.build(:blank_one_two_three)
  @interpreter = VaultTree::V3::Interpreter.new
end

When(/^I attempt fill a vault without providing a master passphrase$/) do
  @user = VaultTree::V3::User.new # No password given in the initializer
  begin
    @contract = @interpreter.close_vault_path(vault_id: 'alice_contract_secret', contract: @contract, user: @user)
  rescue => e
    @exception = e
  end
end

Then(/^a MissingPassphrase exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingPassphrase)
end

Given(/^the broken contract$/) do
  @user = VaultTree::V3::User.new(master_passphrase: 'TEST_USER', external_data: {})
  @contract = FactoryGirl.build(:broken_contract)
  @interpreter = VaultTree::V3::Interpreter.new
end

When(/^I attempt fill a vault with External Data that does not exists$/) do
  begin
    @contract = @interpreter.close_vault_path(vault_id: 'missing_external_data_vault', contract: @contract, user: @user)
  rescue => e
    @exception = e
  end
end

Then(/^a MissingExternalData exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::MissingExternalData)
end

When(/^I attempt fill a vault with my Master Password$/) do
  begin
    @contract = @interpreter.close_vault_path(vault_id: 'fill_with_master_pass_vault', contract: @contract, user: @user)
  rescue => e
    @exception = e
  end
end

Then(/^a FillAttemptMasterPassword exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::FillAttemptMasterPassword)
end

When(/^I attempt to open an empty vault$/) do
  begin
    @contents = @interpreter.retrieve_contents(vault_id: 'empty_vault', contract: @contract, user: @user)
  rescue => e
    @exception = e
  end
end

Then(/^an EmptyVault exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::EmptyVault)
end

When(/^I attempt to open a vault that does not exists$/) do
  begin
    @contents = @interpreter.retrieve_contents(vault_id: 'non_existant_vault', contract: @contract, user: @user)
  rescue => e
    @exception = e
  end
end

Then(/^a VaultDoesNotExist exception is raised$/) do
  @exception.should be_an_instance_of(VaultTree::Exceptions::VaultDoesNotExist)
end

When(/^I attempt fill a vault with an unsupported Keyword$/) do
  begin
    @contract = @interpreter.close_vault_path(vault_id: 'unsupported_keyword', contract: @contract, user: @user)
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
