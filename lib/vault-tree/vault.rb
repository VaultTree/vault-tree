require_relative 'lock_smith'
module VaultTree
  class Vault

    # returns:
    #   string of encrypted cipher text
    def close(plaintext, ciphertext, key)
      return ciphertext if already_closed?(ciphertext)
      symmetric_key?(key) ? sym_encrypt(plaintext, key) : asym_encrypt(plaintext, key)
    end

    # returns:
    #   string of decrypted plaintext vault contents
    def open(ciphertext, key)
      symmetric_key?(key) ? sym_decrypt(ciphertext, key) : asym_decrypt(ciphertext, key)
    end

    protected

    def already_closed?(c)
      c.is_a?(String) && !c.empty?
    end

    def symmetric_key?(k)
      v = k['sym_key']
      !v.nil? && v.is_a?(String) && !v.empty?
    end

    def sym_encrypt(p,lk)
      LockSmith.new(secret_key: lk['sym_key'], message: p).symmetric_encrypt
    end

    def sym_decrypt(c,ulk)
      LockSmith.new(secret_key: ulk['sym_key'], cipher_text: c).symmetric_decrypt
    end

    def asym_encrypt(p,lk)
      LockSmith.new(public_key: lk['asym_pub_key'], private_key: lk['asym_prv_key'], message: p).asymmetric_encrypt
    end

    def asym_decrypt(c,ulk)
      LockSmith.new(public_key: ulk['asym_pub_key'], private_key: ulk['asym_prv_key'], cipher_text: c).asymmetric_decrypt
    end
  end
end
