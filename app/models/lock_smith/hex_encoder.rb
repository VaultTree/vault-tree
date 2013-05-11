require 'rbnacl'

class HexEncoder < Crypto::Encoder
  register :hex

  # Encode a message as hexadecimal
  def encode(bytes)
    bytes.to_s.unpack("H*").first
  end

  # Decode a message from hexadecimal
  def decode(hex)
    [hex.to_s].pack("H*")
  end
end
