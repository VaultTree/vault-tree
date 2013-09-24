module VaultTree
  class Vault
    class Doorman
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def locked_contents
        if vault.empty?
          if vault.asymmetric?
            AsymmetricVaultCloser.new(vault).close
          else
            SymmetricVaultCloser.new(vault).close
          end
        else
          vault.contents
        end
      end

      def unlocked_contents
        if vault.asymmetric?
          AsymmetricVaultOpener.new(vault).open
        else
          SymmetricVaultOpener.new(vault).open
        end
      end
    end
  end
end
