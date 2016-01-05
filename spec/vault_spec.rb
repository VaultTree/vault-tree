require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree/vault'

module VaultTree
  module Refactor
    describe Vault do

      describe '#close | #open' do
        before do
          @msg = 'MY SECRET MESSAGE'
          @ext_ctxt          = 'ae063e061c0cd81174a040a4e18dbc4a57a8b605ef371724fce9701572747273605ef371724f'
          @empty_ctxt        = ''
          @sym_key           = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
          @send_asym_prv_key = '03def0140f339de41e1ee6223b68dd6e0c88273ce33d6d9a7e0989bac38df947'
          @send_asym_pub_key = '7df10933ed4d9ed404f9a143344c9cfc121e2ad15da882375a97d5ae898e6027'
          @rcv_asym_prv_key  = 'f1e37f1b4d519b8b2f392cf2fe30a8fbb3fc2dddb9728581960ce9dc0dec7b4e'
          @rcv_asym_pub_key  = '9b40d4377f54782958be4bb9d0fcd8d029da34dbbdf471482f26b4b33bad8342'
        end

        it 'can open and close with a symmetric key' do
          lk  = {"sym_key" => "#{@sym_key}", "asym_prv_key" => "", "asym_pub_key" => ""}
          ulk  = {"sym_key" => "#{@sym_key}", "asym_prv_key" => "", "asym_pub_key" => ""}
          ciphertext = Vault.new().close(@msg, @empty_ctxt, lk)
          Vault.new().open(ciphertext, ulk).must_equal(@msg)
        end

        it 'can open and close with an asymmetric key' do
          lk =  {"sym_key" => "", "asym_prv_key" => "#{@send_asym_prv_key}", "asym_pub_key" => "#{@rcv_asym_pub_key}"}
          ulk = {"sym_key" => "", "asym_prv_key" => "#{@rcv_asym_prv_key}", "asym_pub_key" => "#{@send_asym_pub_key}"}
          ciphertext = Vault.new().close(@msg, @empty_ctxt, lk)
          Vault.new().open(ciphertext, ulk).must_equal(@msg)
        end

        it 'it returns the given ciphertext when already closed' do
          lk   = {"sym_key" => "#{@sym_key}", "asym_prv_key" => "", "asym_pub_key" => ""}
          ulk  = {"sym_key" => "#{@sym_key}", "asym_prv_key" => "", "asym_pub_key" => ""}
          Vault.new().close(@msg, @ext_ctxt, lk).must_equal(@ext_ctxt)
        end
      end
    end
  end
end
