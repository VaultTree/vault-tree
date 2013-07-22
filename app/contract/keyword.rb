module VaultTree
  module V3
    class Keyword
      attr_reader :word, :contract
      
      def initialize(word,contract)
        @word = word 
        @contract = contract
      end

      def evaluate
        self.send("#{word_base.downcase}", keyword_arg)
      end

      private

      def word_base
        word.match(/[A-Z_]*/).to_s
      end

      def keyword_arg
        word.gsub(/(#{word_base}\[\')|(\'\])/,'').strip if has_args?
      end

      def has_args?
        word.match(/\[/)
      end

      def master_passphrase(arg = nil)
        contract.user_master_passphrase
      end

      def random_number(arg = nil)
        sha rand(10000000)
      end

      def vault_contents(arg = nil)
        Vault.new(arg).retrieve_contents(contract)
      end

      def shared_contract_secret(arg = nil)
        contract.user_shared_contract_secret
      end

      def public_encryption_key(arg = nil)
        contract.user_public_encryption_key
      end

      def decryption_key(arg = nil)
        contract.user_decryption_key 
      end

      def sha(data)
        Crypto::Hash.sha256("#{data}", :base64)
      end
    end
  end
end
