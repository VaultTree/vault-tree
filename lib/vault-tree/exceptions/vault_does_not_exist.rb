module VaultTree
  module Exceptions
    class VaultDoesNotExist < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def runtime_information
        %Q{Can not find vault #{@vault_id}}
      end
    end
  end
end
