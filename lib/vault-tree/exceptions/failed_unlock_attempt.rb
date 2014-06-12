module VaultTree
  module Exceptions
    class FailedUnlockAttempt < LibraryException

      def post_initialize(params)
        @vault_id = params[:vault_id]
        @unlocking_key = params[:unlocking_key]
      end

      def runtime_information
        %Q{
          Attempted to Unlock Vault:
            #{@vault_id}
          With Key:
            #{@unlocking_key}

        * Can you access the vault key?
         - Does the CPU that is executing this particular contract
           have access to the vault key? It could be the case that
           this contract does not permit you to open this particular vault.
         - Are you providing the correct key to the Vault Tree Contract? It
           could be that your are trying to open the vault with the wrong key.
        * Invalid Ciphertext?
          - Have the encrypted contents of the vault been tampered with?
            The underlying Vault Tree Cryto library (NaCl) uses authenticated
            encryption. This ensures that ciphertext cannot be modified.}
      end
    end
  end
end
