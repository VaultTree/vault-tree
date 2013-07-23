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

      def template
%Q[
{
  "header": {},
  "vaults": {
<% contract.vaults.each do |k,v| %>
    "<%= k %>": {
      "owner": "<%= v['owner'] %>",
      "fill_with": "<%= v['fill_with'] %>",
      "lock_with": "<%= v['lock_with'] %>",
      "unlock_with": "<%= v['unlock_with'] %>",
      "contents": "<%= v['contents'] %>"
    }<%= separating_comma(k) %>
<% end %>
  }
}]
      end
    end
  end
end
