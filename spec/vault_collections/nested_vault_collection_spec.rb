require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require_relative '../../lib/vault-tree'

#  Goal: Demonstrate nested vault collections
#
#  Ideas:
#    * vault can contain other vaults
#    * vaults can contain arbitrary collections of vaults
#    * Vault Tree allows the creation of an aribtrarily large tree of nested
#      vaults that can enable crytographic branching and flow of control.
#
describe 'Nested Vault Collection' do

  before do
    # TODO: # Be careful with using spaces in messages.
    # There are some commandline parsing issues.
    @msg = 'The_secret_message_nested_deep_in_the_vault_collection.'
    @ek = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
  end

  it 'blank collection validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', blank_collection, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end

  it 'lock and then open a collection of nested vaults' do
    # Given the blank vault collection:
    json_collection = blank_collection # defined below

    # lock the secret message in the level 3 vault
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close level_3 ek=#{@ek} message=#{@msg}`

    # lock the level 3 vault inside the level 2 vault
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close level_2 ek=#{@ek}`

    # lock the level 2 vault inside the level 1 vault
    json_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt close level_1 ek=#{@ek}`

    # unlock the nested vaults in the correct order to recover the message
    level_2_collection = `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt open level_1 ek=#{@ek}`
    level_3_collection = `VAULTS='#{level_2_collection}';  echo $VAULTS | ./bin/vt open level_2 ek=#{@ek}`
    level_3_content = `VAULTS='#{level_3_collection}';  echo $VAULTS | ./bin/vt open level_3 ek=#{@ek}`
    assert_equal @msg, level_3_content

    # Or alternatively ....
    # since the contents of nested vaults are properly formed json vault collections,
    # you can unlock the final contents succinctly with UNIX pipes
    assert_equal @msg, `VAULTS='#{json_collection}';  echo $VAULTS | ./bin/vt open level_1 ek=#{@ek} | ./bin/vt open level_2 ek=#{@ek} | ./bin/vt open level_3 ek=#{@ek}`
  end

  def blank_collection
  %Q[
  {
    "vaults": {
      "level_1": {
        "contents": { "vaults": ["level_2"] },
        "lock_key": { "sym_key": { "external_input": "ek" }},
        "unlock_key": { "sym_key": { "external_input": "ek" } },
        "ciphertext": ""
      },
      "level_2": {
        "contents": { "vaults": ["level_3"] },
        "lock_key": { "sym_key": { "external_input": "ek" }},
        "unlock_key": { "sym_key": { "external_input": "ek" } },
        "ciphertext": ""
      },
      "level_3": {
        "contents": { "external_input": "message"},
        "lock_key": { "sym_key": { "external_input": "ek" }},
        "unlock_key": { "sym_key": { "external_input": "ek" } },
        "ciphertext": ""
      }
    }
  }
  ]
  end
end
