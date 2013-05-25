class String
  def compress
    gsub("\n", '').squeeze(' ').strip
  end

  def normalized
    de_ser = ActiveSupport::JSON.decode(self)
    ActiveSupport::JSON.encode(de_ser)
  end
end
