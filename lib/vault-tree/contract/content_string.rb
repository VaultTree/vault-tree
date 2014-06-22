module VaultTree
  class ContentString
    attr_reader :content_string

    def initialize(content_string)
      @content_string = content_string
    end

    def lock(k)
      already_locked? ? content_string : ciphertext(k)
    end

    def unlock(k)
      empty_contents? ? content_string : plaintext(k)
    end

    private

    def ciphertext(k)
      ContentCiphertext.new(content_string, k).evaluate
    end

    def plaintext(k)
      ContentPlaintext.new(content_string, k).evaluate
    end

    def already_locked?
      ! empty_contents?
    end

    def empty_contents?
      (content_string.nil? || content_string.empty?)
    end
  end
end
