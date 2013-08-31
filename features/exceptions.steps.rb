Given(/^the broken contract$/) do
  @user = VaultTree::V3::User.new(master_passphrase: 'TEST_USER')
  @contract = FactoryGirl.build(:broken_contract)
  @interpreter = VaultTree::V3::Interpreter.new
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

When(/^I attempt to open a vault with an empty vault in its lock path$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^not yet implemented$/) do
  pending 'Scenario is TBD' 
end
