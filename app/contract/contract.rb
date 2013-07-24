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
        ContractPresenter.new(self).as_json
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

      def user_messages(arg) 
        user.messages[arg]
      end

      private
      attr_accessor :contract


      def non_empty_contents?(vault_id)
        vaults[vault_id]['contents'].non_empty?
      end


    end
  end
end

class String
  def non_empty?
    ! self.empty?
  end
end
