module VaultTree
  module V3
    class KeywordInterpreter
      attr_reader :word, :contract
      
      def initialize(word,contract)
        @word = word 
        @contract = contract
      end

      def evaluate
        self.send("#{word_base.downcase}", keyword_arg)
      end

      def wip_evaluate # start here
        keyword_class_name.new(contract, keyword_arg).evaluate
      end

      private

      def keyword_class_name
        word_base.downcase.camelize.constantize
      end

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
        MasterPassphrase.new(contract, arg).evaluate
      end

      def random_number(arg = nil)
        RandomNumber.new(contract,arg).evaluate 
      end

      def vault_contents(arg = nil)
        VaultContents.new(contract, arg).evaluate
      end

      def shared_contract_secret(arg = nil)
        SharedContractSecret.new(contract, arg).evaluate
      end

      def public_encryption_key(arg = nil)
        PublicEncryptionKey.new(contract, arg).evaluate
      end

      def decryption_key(arg = nil)
        DecryptionKey.new(contract,arg).evaluate
      end

      def messages(arg = nil)
        Message.new(contract,arg).evaluate
      end

    end
  end
end
