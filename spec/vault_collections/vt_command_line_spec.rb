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

  it 'vt cli can lock and unlock a basic vault' do
    json_collection = `VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt close solo msg=#{@msg} ek=#{@ek}`
    recovered_message = `VAULTS='#{json_collection}'; echo $VAULTS | ./bin/vt open solo ek=#{@ek}`
    recovered_message.must_equal @msg
  end

  it 'the exit code is 0 on lock and unlock' do
    silence_stream(STDOUT) do
      system("VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt close solo msg=#{@msg} ek=#{@ek}")
    end
    $?.to_i.must_equal(0)
  end

  it 'the exit code is 0 when no collection piped and no arguments are given' do
    silence_stream(STDOUT) do
      system("./bin/vt")
    end
    $?.to_i.must_equal(0)
  end

  it 'the exit code is 0 when a valid collection piped and valid arguments are given' do
    silence_stream(STDOUT) do
      system("VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt close solo msg=#{@msg} ek=#{@ek}")
    end
    $?.to_i.must_equal(0)
  end

  it 'the exit code is NOT 0 when a collection IS piped and NO arguments are given' do
    silence_stream(STDOUT) do
      system("VAULTS='#{blank_collection}'; echo $VAULTS | ./bin/vt")
    end
    $?.to_i.wont_equal(0)
  end

  it 'the exit code is NOT 0 when a collection IS NOT piped and arguments ARE given' do
    silence_stream(STDOUT) do
      system("./bin/vt close solo msg=#{@msg} ek=#{@ek}")
    end
    $?.to_i.wont_equal(0)
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

  # anything written to STDOUT here will be silenced
  # reference: Rails 3 source. http://apidock.com/rails/v3.2.13/Kernel/silence_stream
  def silence_stream(stream)
    old_stream = stream.dup
    stream.reopen(RbConfig::CONFIG['host_os'] =~ /mswin|mingw/ ? 'NUL:' : '/dev/null')
    stream.sync = true
    yield
  ensure
    stream.reopen(old_stream)
  end

end
