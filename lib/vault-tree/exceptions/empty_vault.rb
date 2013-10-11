module VaultTree
  module Exceptions
    class EmptyVault < VaultTreeException
      # Cant open emtpy vaults
      # Attempted to open an empty vault
    end
  end
end
