module VaultTree
  module V3
    class Vault
      include Contract
      attr_reader :vault_id, :user

      def initialize(opts)
        @vault_id = opts[:vault_id]
        @user = opts[:user]
      end

      def ciphertext
        'ciphertext'
      end

      def plaintext
        'plaintext'
      end
    end
  end
end
