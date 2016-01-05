require_relative 'expressions/external_input'
require_relative 'expressions/open_key'
require_relative 'expressions/random_key'
require_relative 'expressions/computed_pub_key'
require_relative 'expressions/vault_contents'
require_relative 'expressions/vaults'

module VaultTree
  class Expression

    def initialize(e)
      @e = e
    end
    attr_reader :e

    # each expression object will be instantiated
    # with the string passed in from the vault collection.
    # we expect an evaluate method to be called in all cases.
    def expression_object
      e.nil? ? NullExpression.new : keyword_mapping[e_key].new(e_value)
    end

    def e_key
      e.keys.first
    end

    def e_value
      e.values.first
    end

    # We can confidently do a direct lookup on the given keyword
    # because of the prior JSON Schema validation.
    # There is no need to be defensive here. If we find keyword
    # edge cases as we iterate, we should look to make the schema
    # definitions more complete.
    def keyword_mapping
      {
        "external_input"   => Expressions::ExternalInput,
        "open_key"         => Expressions::OpenKey,
        "random_key"       => Expressions::RandomKey,
        "computed_pub_key" => Expressions::ComputedPubKey,
        "vault_contents"   => Expressions::VaultContents,
        "vaults"           => Expressions::Vaults
      }
    end
  end
end

module VaultTree
  class NullExpression
    def evaluate(c, vault_id)
      ''
    end
  end
end
