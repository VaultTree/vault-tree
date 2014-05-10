module VaultTree
  module Exceptions
    class MissingExternalData < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def name
        'Missing External Data'
      end

      def runtime_information
        %Q{
          It looks like you need to provide external input for:

          Vault:
          #{@vault_id}
        }
      end
    end
  end
end
