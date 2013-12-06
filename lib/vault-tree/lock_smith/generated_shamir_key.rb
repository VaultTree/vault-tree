module VaultTree
  module LockSmith
    class GeneratedShamirKey

      def initialize(params)
        @outstanding_shares = params[:outstanding_shares]
        @recovery_threshold = params[:recovery_threshold]
      end

      # String representation of the newly generated sharmir key
      #
      # @return [String] Secure Hash digest of the generated secret integer
      def key
        CryptoHash.compute secret_string
      end

      # Shares associated with the newly generated Sharmir key
      #
      # @return [Array] Array of strings
      def shares
        shares_array.map{|s| s.to_s}
      end

      # Fixnum representation if string value given
      #
      # @return [FixNum]
      def outstanding_shares
        @outstanding_shares.to_i
      end

      # Fixnum representation if string value given
      #
      # @return [FixNum]
      def recovery_threshold
        @recovery_threshold.to_i
      end

      private

      def secret_string
        get_or_create_secret
        shamir_object.secret.to_s
      end

      def shares_array
        shamir_object.shares
      end

      def shamir_object
        @shamir_object ||= SecretSharing::Shamir.new(outstanding_shares, recovery_threshold)
      end

      def get_or_create_secret
        shamir_object.create_random_secret
      end
    end
  end
end

