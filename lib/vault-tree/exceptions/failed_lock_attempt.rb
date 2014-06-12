module VaultTree
  module Exceptions
    class FailedLockAttempt < LibraryException

      def post_initialize(params)
        @vault_id = params[:vault_id]
        @locking_key = params[:locking_key]
      end

      def runtime_information
        %Q{
          Attempted to Lock Vault:
            #{@vault_id}
          With Key:
            #{@locking_key}
        }
      end
    end
  end
end
