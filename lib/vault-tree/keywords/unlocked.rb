module VaultTree
  class Unlocked < Keyword

    def evaluate
      LockSmith.new(message: 'UNLOCKED').secure_hash
    end

  end
end
