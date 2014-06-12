module VaultTree
  module Exceptions
    class InvalidExternalInput  < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def runtime_information
        %Q{
          Vault:
          #{@vault_id}
        }
      end
    end
  end
end
