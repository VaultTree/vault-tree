module VaultTree
  module Exceptions
    class InvalidExternalInput  < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def name
        'Invalid External Input'
      end

      def runtime_information
        %Q{
          Invalid input for:

          Vault:
          #{@vault_id}
        }
      end

      def background
        %Q{
          Remember:
            * External Input is must be a Ruby Hash
            * Do not pass a nil value as input
            * Do not pass an empty string as input
        }
      end
    end
  end
end
