require 'secretsharing'

module VaultTree
  module Crypto
    class ShamirKeyShares

      def initialize(params)
        @outstanding_shares = params[:outstanding_shares]
        @recovery_threshold = params[:recovery_threshold]
      end

      # JSON representation of a collection of secret shares
      #
      def generate
        json_shares_mapping
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

      protected

      def json_shares_mapping
        sh = {}
        i = 1; shares.each{ |s| sh[i.to_s] = s; i = i + 1;}
        JSON.generate(sh)
      end

      def shamir_object
        @shamir_object ||= SecretSharing::Shamir.new(outstanding_shares, recovery_threshold)
      end

      # Shares associated with the newly generated Sharmir key
      #
      # @return [Array] Array of strings
      def shares
        create_secret
        shares_array.map{|s| s.to_s}
      end

      def create_secret
        shamir_object.create_random_secret unless secret_set?
      end

      def secret_set?
        shamir_object.secret_set?
      end

      def shares_array
        shamir_object.shares
      end

    end
  end
end
