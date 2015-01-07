module VaultTree
  module Notifications
    class FailedLockAttempt < Notification

      def post_initialize(params)
        @vault_id = params[:vault_id]
        @locking_key = params[:locking_key]
      end

      def runtime_information
        %Q{
          Attempted to Lock Vault: #{@vault_id}

          * Is the vault_id you provided valid?
          * Are you providing the correct key to the Vault Tree Contract?
            - It could be that your are trying to lock the vault with the wrong key.
            - Can your contract access the locking key?
            - You could be attempting to fetch the key from a vault that you do not have access to.}
      end
    end
  end
end
