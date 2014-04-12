module VaultTree
  module Exceptions
    class VaultDoesNotExist < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def name
        'Vault Does Not Exist'
      end

      def search_word
        'vault_does_not_exist'
      end

      def runtime_information
        %Q{Can not find vault #{@vault_id}}
      end
    end
  end
end
