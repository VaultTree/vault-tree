require 'secretsharing'

module VaultTree
  module Crypto
    class AssembledShamirKey
      attr_reader :key_shares

      # Creates a new AssembledShamirKey object
      #
      # @param [Hash]
      # @option opts [Array] :key_shares Secret Shares as strings
      #
      # @return [AssembledShamirKey]
      def initialize(params)
        @key_shares = params[:key_shares]
        validate_key_shares
      end

      # Recovers the shared secret from the shares provided
      # in the initializer.
      #
      # @return [String] Secure Hash digest of the assembled secret
      def assemble
        LockSmith.new(message: assembled_secret).secure_hash
      end

      private

      def assembled_secret
        assemble_secret_object
        assembled_object_string
      end

      def assemble_secret_object
        key_shares.each { |s| assembled_object << s }
      end

      def assembled_object
        @assembled_object ||= SecretSharing::Shamir.new(total_key_shares)
      end

      def assembled_object_string
        assembled_object.secret.to_s
      end

      def total_key_shares
        key_shares.length
      end

      def validate_key_shares
        raise(TypeError, 'nil key_shares passed') if key_shares.nil?
        raise(TypeError) if any_none_string_key_shares?
      end

      def any_none_string_key_shares?
        key_shares.any? { |s| not_a_string?(s)}
      end

      def not_a_string?(s)
        ! s.kind_of?(String)
      end
    end
  end
end
