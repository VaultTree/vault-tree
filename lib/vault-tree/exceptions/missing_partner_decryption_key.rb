module VaultTree
  module Exceptions
    class MissingPartnerDecryptionKey < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
      end

      def name
        'MissingPartnerDecryptionKey'
      end

      def search_word
        'missing_partner_decryption_key'
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
