require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/vault-tree/expression'

module VaultTree
  describe Expression do

    describe '#vault_contents' do
      it 'returns the correct expression object' do
        o = Expression.new({"vault_contents" => "id"}).expression_object
        o.is_a?(Expressions::VaultContents).must_equal(true)
      end
    end

    describe '#vault_collection' do
      it 'returns the correct expression object' do
        o = Expression.new({"vaults" => ['v1', 'v2']}).expression_object
        o.is_a?(Expressions::Vaults).must_equal(true)
      end
    end

    describe '#random_key' do
      it 'returns the correct expression object' do
        o = Expression.new({"random_key" => "some_key"}).expression_object
        o.is_a?(Expressions::RandomKey).must_equal(true)
      end
    end

    describe '#open_key' do
      it 'returns the correct expression object' do
        o = Expression.new({"open_key" => "some_key"}).expression_object
        o.is_a?(Expressions::OpenKey).must_equal(true)
      end
    end

    describe '#computed_pub_key' do
      it 'returns the correct expression object' do
        o = Expression.new({"computed_pub_key" => "some_key"}).expression_object
        o.is_a?(Expressions::ComputedPubKey).must_equal(true)
      end
    end

    describe '#external_input' do
      it 'returns the correct expression object' do
        o = Expression.new({"external_input" => "message"}).expression_object
        o.is_a?(Expressions::ExternalInput).must_equal(true)
      end
    end
  end
end
