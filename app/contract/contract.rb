module VaultTree
  module V3
    module Contract
      def contract
        Support::JSON.decode(File.read(contract_filename))
      end

      def contract_filename
        PathHelpers.one_two_three_030
      end
    end
  end
end
