module VaultTree
  module Exceptions
    class EmptyVault < LibraryException

      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def name
        'Empty Vault'
      end

      def search_word
        'empty_vault'
      end

      def background
        %Q{
          Vault Tree does not allow you to open an empty vault.
          An empty vault means the the vault contents field is an empty
          string.
        }
      end

      def runtime_information
        %Q{The following vault was empty: #{@vault_id}}
      end

      def troubleshooting_questions
        %Q{
          * Are you closing the vaults in the right order?
          * Are you attempting to open a vault before all
            of the vaults that it references have been closed?
        }
      end
    end
  end
end
