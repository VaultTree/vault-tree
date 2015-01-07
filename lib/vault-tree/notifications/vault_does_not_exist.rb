module VaultTree
  module Notifications
    class VaultDoesNotExist < Notification
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def runtime_information
        %Q{
          Vault Does Not Exist: #{@vault_id}
        }
      end
    end
  end
end
