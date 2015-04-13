require 'rbnacl/libsodium'

module VaultTree
  # VaultTree::LockSmith Interface to Crypto Primatives
  #
  # This class provides a interface all of the cryptographic functions used
  # by Vault Tree.
  #
  # Specifically, it exposes the functionallity of the RbNaCl Gem
  class LockSmith

    def initialize(opts = {})
      @message = opts[:message]
      @cipher_text = opts[:cipher_text]
      @secret_key = opts[:secret_key]
      @private_key = opts[:private_key]
      @public_key = opts[:public_key]
    end

    # Random Key for Semetric Encryption
    #
    # @return [String] Hex encoded Secret Key
    def generate_secret_key
      bin2hex RbNaCl::Hash.sha256(RbNaCl::Random.random_bytes(128))
    end

    # Randomly Generated Private Key
    #
    # @return [String] Hex encoded Private Key
    def generate_private_key
      bin2hex(RbNaCl::PrivateKey.generate.to_bytes)
    end

    # Public Key Derived from a given private key
    #
    # @return [String] Hex encoded Public Key
    def generate_public_key
      bin2hex(RbNaCl::PrivateKey.new(private_key).public_key.to_bytes)
    end

    # Symmetric Encryption of the given message
    #
    # @return [String] Hex encoded message ciphertext
    def symmetric_encrypt
      bin2hex RbNaCl::RandomNonceBox.from_secret_key(secret_key).box(message)
    end

    # Symmetric Decryption of the given ciphertext
    #
    # @return [String] Decoded plaintext message
    def symmetric_decrypt
      RbNaCl::RandomNonceBox.from_secret_key(secret_key).open(cipher_text)
    end

    # Asymmetric Encryption of the given message
    #LockSmith.new()
    #
    # @return [String] Hex encoded message ciphertext
    def asymmetric_encrypt
      pri = RbNaCl::PrivateKey.new(private_key)
      pub = RbNaCl::PublicKey.new(public_key)
      box = RbNaCl::Box.new(pub,pri)
      bin2hex RbNaCl::RandomNonceBox.new(box).box(message)
    end

    # Asymmetric Decryption of the given ciphertext
    #
    # @return [String] Decoded plaintext message
    def asymmetric_decrypt
      pri = RbNaCl::PrivateKey.new(private_key)
      pub = RbNaCl::PublicKey.new(public_key)
      box = RbNaCl::Box.new(pub,pri)
      RbNaCl::RandomNonceBox.new(box).open(cipher_text)
    end

    # Random number generation
    #
    # This uses the underlying source of random number generation on the OS, so
    # /dev/urandom on UNIX-like systems, and the MS crypto providor on windows.
    def random_number
      bin2hex RbNaCl::Random.random_bytes
    end

    # Random key generation
    #
    # Generate a random number using the random_number() method
    # now hash the the generated number using the secure_hash() method
    def random_key
      bin2hex RbNaCl::Hash.sha256(RbNaCl::Random.random_bytes)
    end

    # Returns the SHA-256 hash of the given data
    #
    # There's no streaming done, just pass in the data and be done with it.
    #
    # @raise [CryptoError] If the hashing fails for some reason.
    #
    # @return [String] The SHA-256 hash as hex
    def secure_hash
      bin2hex RbNaCl::Hash.sha256(message)
    end

    private

    def message; @message end

    # Locksmith always expects hex representations
    # of keys and ciphertext. Convert to binary to
    # give to RbNaCl.
    def cipher_text; hex2bin @cipher_text end
    def private_key; hex2bin @private_key end
    def public_key; hex2bin @public_key end
    def secret_key; hex2bin @secret_key end

    # Hex encodes a message
    #
    # @param [String] The bytes to encode
    #
    # @return [String] hexadecimal
    def bin2hex(bytes)
      bytes.to_s.unpack("H*").first
    end

    # Hex decodes a message
    #
    # @param [String] hex to decode.
    #
    # @return [String] crisp and clean bytes
    def hex2bin(hex)
      [hex.to_s].pack("H*")
    end

  end
end
