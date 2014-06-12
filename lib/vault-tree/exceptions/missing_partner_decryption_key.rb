module VaultTree
  module Exceptions
    class MissingPartnerDecryptionKey < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def runtime_information
        %Q{
          Missing Decryption Key For:
            #{@vault_id}
        }
      end
    end
  end
end
