require 'fileutils'

Given(/^a clean start$/) do
  Dir.chdir(ENV['HOME'])
  FileUtils.rm_rf(ENV['HOME']+'/.vault-tree')
end

Given(/^we have some objects$/) do
  content_array = [LockSmith::Id.new('123456'), LockSmith::Id.new('654321')]
  @rack = LockSmith::Rack.new(contents: content_array)
end

Given(/^we create a symmetric vault and put the objects inside$/) do
  @vault = LockSmith::SymmetricVault.new(rack: @rack)
end

When(/^we ask for the contents$/) do
  @retrieved_rack = @vault.remove_rack
end

Then(/^we get the contents back$/) do
  @retrieved_rack.same_as?(@rack).should == true
end

When(/^we serialize then deserialize the vault$/) do
  path = "#{Dir.pwd}/vault_io.json"
  @file = File.new(path, "w+")
  @json = @vault.as_json
  File.open(@file, 'w') { |file| file.write("#{@json}")}
  retrieved_json = File.read(path)
  @imported_vault = LockSmith::SymmetricVault.new(json: retrieved_json)
  @retrieved_rack = @imported_vault.rack
end

Then(/^we get the clear text contents back$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^we lock the vault$/) do
  @key = LockSmith::SymmetricVaultKey.new
  @vault.lock(@key)
end

Then(/^we get nothing back$/) do
  @retrieved_rack.should_be Nil
end

Given(/^lock the objects in a symetric vault$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^we unlock the vault$/) do
  pending # express the regexp above with the code you wish you had
end
