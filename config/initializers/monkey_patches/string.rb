class String
  def compress
    gsub("\n", '').gsub(/\s+/, "").squeeze(' ').strip
  end
end
