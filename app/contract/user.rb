module VaultTree
  class User
    attr_reader :external_data

    def initialize(opts = {})
      @master_passphrase = opts[:master_passphrase]
      @external_data = opts[:external_data] 
    end

    def master_passphrase
      raise Exceptions::MissingPassphrase if passphrase_missing?
      @master_passphrase
    end

    private

    def passphrase_missing?
      @master_passphrase.nil?
    end
  end
end
