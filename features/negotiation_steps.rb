Given(/^"(.*?)" has the blank contract$/) do |arg1|
  @contract_json = File.open(VaultTree::PathHelpers.one_two_three_contract).read
  @bob = VaultTree::AutoBots::Bob.new()
  @bob.take_contract(@contract_json)
  @bob.hand_over_contract.should == @contract_json
end

When(/^"(.*?)" FLS Vault '\[(\d+),(\d+),(\d+)\]'$/) do |arg1, arg2, arg3, arg4|
  pending # express the regexp above with the code you wish you had
end

When(/^"(.*?)" FLS Vault '\[(\d+),(\d+)\]'$/) do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

When(/^"(.*?)" FLS Vault '\[(\d+)\]'$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^each vault is properly locked and signed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^"(.*?)" FLS each contract Vault$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^"(.*?)" Affirms, Signs, and Sends the contract to "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" has and is ready to enforce the contract$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
