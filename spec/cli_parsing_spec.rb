require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/util/cli_parsing.rb'

describe 'CLI Validation' do

  include VaultTree::CliParsing

  describe 'valid actions' do

    describe '#display_summary?' do

      it 'returns true when NO json vault collection is piped in AND NO arguments are given' do
        stdin_data = nil
        arg_vector = []
        display_summary?(stdin_data, arg_vector).must_equal(true)
      end

      it 'returns false when a json vault collection IS piped AND arguments ARE given' do
        stdin_data = blank_collection
        arg_vector = ['open', 'solo', 'ek=ext_key', 'msg=message']
        display_summary?(stdin_data, arg_vector).must_equal(false)
      end

      it 'returns false when a json vault collection IS piped  AND NO arguments are given' do
        stdin_data = blank_collection
        arg_vector = []
        display_summary?(stdin_data, arg_vector).must_equal(false)
      end

      it 'returns false when NO json vault collection is piped AND arguments ARE given' do
        stdin_data = nil
        arg_vector = ['open', 'solo', 'ek=ext_key', 'msg=message']
        display_summary?(stdin_data, arg_vector).must_equal(false)
      end
    end

    describe '#parse_action!' do

      before do
        stdin_data = blank_collection
        arg_vector = ['open', 'solo', 'ek=ext_key', 'msg=message']
        @result = parse_action!(stdin_data, arg_vector)
      end

      it 'returns a hash' do
        @result.is_a?(Hash).must_equal(true)
      end

      it 'hash with keys input, door_action, vault_id, external_input' do
        @result.keys.include?(:input).must_equal(true)
        @result.keys.include?(:door_action).must_equal(true)
        @result.keys.include?(:vault_id).must_equal(true)
        @result.keys.include?(:external_input).must_equal(true)
      end

      it 'hash does NOT have keys for vaults and arguments' do
        @result.keys.include?(:vaults).must_equal(false)
        @result.keys.include?(:arguments).must_equal(false)
      end

      it 'sets the door action' do
        @result[:door_action].must_equal('open')
      end

      it 'sets the vault id' do
        @result[:vault_id].must_equal('solo')
      end

      it 'the inputs vaults are a string' do
        @result[:input].is_a?(String).must_equal(true)
      end

      it 'sets the inputs vaults' do
        @result[:input].must_equal(blank_collection)
      end

      it 'external inputs are a hash' do
        @result[:external_input].is_a?(Hash).must_equal(true)
      end

      it 'set the external inputs' do
        @result[:external_input]['ek'].must_equal('ext_key')
        @result[:external_input]['msg'].must_equal('message')
      end
    end
  end

  describe 'display summary' do
  end

  describe 'error cases' do
  end

  describe '#output_setup' do
    it 'the returned hash has the correct output key and value types' do
      input = {vaults: blank_collection, arguments: ['open', 'solo', 'ed=edv']}
      output_setup(input).must_equal({ vaults: blank_collection, arguments: ['open', 'solo', 'ed=edv'], input: '', door_action: '', vault_id: '', external_input: {}})
    end
  end

  describe '#extract_output' do
    it 'the returned hash only the relavent output keys' do
      input = { vaults: blank_collection, arguments: ['open', 'solo', 'ed=edv'], input: '', door_action: '', vault_id: '', external_input: {}}
      extract_output(input).must_equal({input: '', door_action: '', vault_id: '', external_input: {}})
    end
  end

  describe '#vault_id' do
    it 'set the vault id' do
      input = {arguments: ['open', 'solo', 'ed=edv'], vault_id: '' }
      vault_id(input)[:vault_id].must_equal('solo')
    end

    it 'raises if vault id is not a string' do
      input = {arguments: ['open', nil, 'ed=edv'], vault_id: '' }
      proc {vault_id(input)}.must_raise(RuntimeError)
    end

    it 'raises if vault id is empty' do
      input = {arguments: ['open', '', 'ed=edv'], vault_id: '' }
      proc {vault_id(input)}.must_raise(RuntimeError)
    end

    it 'raises if vault id has only empty chars' do
      input = {arguments: ['open', '', 'ed=edv'], vault_id: '      ' }
      proc {vault_id(input)}.must_raise(RuntimeError)
    end
  end

  describe '#json_input' do
    it 'set the json input' do
      input = {vaults: blank_collection ,arguments: ['open', 'id', 'ed=edv'], input: '' }
      json_input(input)[:input].must_equal(blank_collection)
    end
  end

  describe '#door_action' do
    it 'set the door action' do
      input = {arguments: ['open', 'id', 'ed=edv'], door_action: '' }
      door_action(input)[:door_action].must_equal('open')
    end

    it 'raises if action is not valid' do
      input = {arguments: ['opentypo', 'id', 'ed=edv'], door_action: '' }
      proc { door_action(input) }.must_raise(RuntimeError)
    end

    it 'raises if action is nil' do
      input = {arguments: [nil, 'id', 'ed=edv'], door_action: '' }
      proc { door_action(input) }.must_raise(RuntimeError)
    end
  end

  class MockException
    def message
      'this is a test'
    end
  end

  describe '#parse_exception!' do
    it 'returns a hash with the exception name and message' do
      e = MockException.new
      parse_exception!(e).must_equal({type: 'MockException', message: 'this is a test'})
    end
  end

  describe '#validate_args_vector!' do
    # here we want to do things like:
    # * make sure the length is within the bounds
    # * it is present.
    # * not empty
  end

  describe '#external_input' do
    it 'set the external input' do
      input = {arguments: ['open', 'id', 'ek=edv', 'msg=message'], external_input: {} }
      external_input(input)[:external_input].must_equal({'ek' => 'edv', 'msg' => 'message'})
    end

    it 'raises if ei does not contain = delimiter' do
      input = {arguments: ['open', 'id', 'ek:edv', 'msg=message'], external_input: {} }
      proc { external_input(input) }.must_raise(RuntimeError)
    end
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
