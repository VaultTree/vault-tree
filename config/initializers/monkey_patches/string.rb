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

  def constantize
    Object.const_get(self)
  end

  #def camelize
  #  self.split("_").each {|s| s.capitalize! }.join("")
  #end

  #def underscore
  #  self.scan(/[A-Z][a-z]*/).join("_").downcase
  #end

end
