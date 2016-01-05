require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require 'open3'

describe 'command line utility' do

  before do
    @msg = 'The_Secret_Message!'
    @ek = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
  end

  it 'blank collection validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', blank_collection, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end

  it 'pass the vault collection and options to the vt command line application' do
    json_collection = `VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt close solo msg=#{@msg} ek=#{@ek}`
    recovered_message = `VAULTS='#{json_collection}'; echo $VAULTS | ./bin/vt open solo ek=#{@ek}`
    recovered_message.must_equal @msg
  end

  it 'exit 1 when open or close argument is not passed' do
    skip
    out, err, process = Open3.capture3("VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt solo msg=#{@msg} ek=#{@ek}")
    puts out
    #proc {`VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt solo msg=#{@msg} ek=#{@ek}`}.must_raise(ArgumentError)
  end

  def blank_collection
  %Q[
  {
    "vaults": {
      "solo": {
        "contents": { "external_input": "msg" },
        "lock_key": { "sym_key": { "external_input": "ek" }},
        "unlock_key": { "sym_key": { "external_input": "ek" } },
        "ciphertext": ""
      }
    }
  }
  ]
  end
end
