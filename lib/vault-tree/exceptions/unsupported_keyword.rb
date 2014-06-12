module VaultTree
  module Exceptions
    class UnsupportedKeyword < LibraryException
      def post_initialize(params)
        @vault_id = params[:vault_id]
        @keyword = params[:keyword]
      end

      def runtime_information
        %Q{
          It looks like you have used an unsupported Keyword.

          Attempted Keyword:
          #{@keyword}

          Vault:
          #{@vault_id}
        }
      end
    end
  end
end
