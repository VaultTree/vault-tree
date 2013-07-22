module VaultTree
  module V3
    class Contract
      attr_accessor :user
      attr_reader :json

      def initialize(json)
        @json = json
        @contract = Support::JSON.decode(json)
        @user = nil
      end

      def vault_closed?(vault_id)
        non_empty_contents?(vault_id)
      end

      def vaults
        contract["vaults"]
      end

      def close_vault_path(vault_id) 
        Vault.new(vault_id).close_all_ancestors(self) # => a contract
      end

      def retrieve_vault_contents(vault_id) 
        Vault.new(vault_id).retrieve_contents(self) # => a contract
      end

      def set_vault_contents(vault_id, encrypted_content)
        vaults[vault_id]['contents'] = encrypted_content 
        self
      end

      def as_json
        ERB.new(template).result(binding)
      end

      def user_master_passphrase
        user.master_passphrase
      end

      def user_shared_contract_secret
        user.shared_contract_secret
      end

      def user_public_encryption_key
        user.public_encryption_key
      end

      def user_decryption_key 
        user.decryption_key 
      end

      private
      attr_accessor :contract


      def non_empty_contents?(vault_id)
        vaults[vault_id]['contents'].non_empty?
      end

      def separating_comma(k)
        ',' unless last_vault?(k)
      end

      def last_vault?(k)
        k.eql?(vaults.keys.last)
      end

      def template
%Q[
{
  "header": {},
  "vaults": {
<% vaults.each do |k,v| %>
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

class String
  def non_empty?
    ! self.empty?
  end
end
