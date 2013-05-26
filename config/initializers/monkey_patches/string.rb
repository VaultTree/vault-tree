class String
  def compress
    gsub("\n", '').squeeze(' ').strip
  end

  def normalized
    de_ser = VaultTree::Support::JSON.decode(self)
    VaultTree::Support::JSON.encode(de_ser)
  end

  def checksum
    Digest::SHA1.hexdigest(self)
  end
end
