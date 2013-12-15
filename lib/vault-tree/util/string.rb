class String
  def compress
    gsub("\n", '').squeeze(' ').strip
  end

  def extract_ancestor_id
    self.gsub(/((CONTENTS|KEY)\[\')|(\'\])/,'').strip
  end

  def checksum
    Digest::SHA1.hexdigest(self)
  end

  def non_empty?
    ! self.empty?
  end

  def camelize
    self.split("_").each {|s| s.capitalize! }.join("")
  end
end
