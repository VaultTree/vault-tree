module VaultTree
  module Notifications
    class FailedLockAttempt < Notification

      def post_initialize(params)
        @vault_id = params[:vault_id]
        @locking_key = params[:locking_key]
      end

      def runtime_information
        %Q{
          Attempted to Lock Vault:
            #{@vault_id}
        }
      end
    end
  end
end
