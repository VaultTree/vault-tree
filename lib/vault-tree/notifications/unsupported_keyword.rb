module VaultTree
  module Notifications
    class UnsupportedKeyword < Notification
      def post_initialize(params)
        @vault_id = params[:vault_id]
        @keyword = params[:keyword]
      end

      def runtime_information
        %Q{
          Unsupported Keyword: #{@keyword}
          Vault: #{@vault_id}
        }
      end
    end
  end
end
