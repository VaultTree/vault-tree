module VaultTree
  module V3
    class RandomNumber < Keyword

      def evaluate
        sha rand(10000000)
      end

      private

      def sha(data)
        Crypto::Hash.sha256("#{data}", :base64)
      end
    end
  end
end
