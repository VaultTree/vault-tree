When(/^we lock the first and second vault$/) do
  @contract = VaultTree::Contract.new(@contract).close_vault('first_vault')
  @contract = VaultTree::Contract.new(@contract).close_vault('second_vault')
end

When(/^we lock the subcontract vault$/) do
  @contract = VaultTree::Contract.new(@contract).close_vault('subcontract_vault')
end

Then(/^a new contract is and locked into the subcontract vault$/) do
end

When(/^we open the subcontract vault$/) do
  @subcontract = VaultTree::Contract.new(@contract).open_vault('subcontract_vault')
end

Then(/^we can recover the newly written subcontract$/) do
  @first_vault_contents = VaultTree::Contract.new(@contract).open_vault('first_vault')
  @first_vault_subcontract_contents = VaultTree::Contract.new(@subcontract).open_vault('first_vault')
  assert_equal @first_vault_contents, @first_vault_subcontract_contents
end
