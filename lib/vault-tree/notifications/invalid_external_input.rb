module VaultTree
  module Notifications
    class InvalidExternalInput < Notification
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def runtime_information
        %Q{
          Invalid External Input for Vault: #{@vault_id}

          * External input must be deserialized as a Hash
          * Input should not be nil or empty
        }
      end
    end
  end
end
