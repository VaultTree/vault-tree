require 'json'

module VaultTree
  module V3
    class ContractPresenter
      attr_reader :contract

      def initialize(contract)
        @contract = contract
      end

      def as_json
        ERB.new(template).result(binding)
      end

      private

      def separating_comma(k)
        ',' unless last_vault?(k)
      end

      def last_vault?(k)
        k.eql?(contract.vaults.keys.last)
      end

      def vault_as_json(v)
        JSON.pretty_generate(v)
      end

      def template
        %Q[
{
"header": {},
  "vaults": {
<%contract.vaults.each do |k,v|%>
"<%=k%>":<%=vault_as_json(v)%><%=separating_comma(k)%>
<% end %>
  }
}
        ]
      end
    end
  end
end
