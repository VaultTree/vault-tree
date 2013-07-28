class String
  def compress
    gsub("\n", '').squeeze(' ').strip
  end

  def checksum
    Digest::SHA1.hexdigest(self)
  end

  def non_empty?
    ! self.empty?
  end
end
