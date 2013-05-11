module VaultTree
  class Contract
    attr_reader :string

    def initialize(json, opts = {contract_password: nil})
      @contract_password = opts[:contract_password] || no_contract_key
      @string = json
    end

    def enforce
      active_key = contract_password 
      vault_collection.each do |vault_id, vault_string|
        puts 'TRACE TWS'
        puts vault_id
        puts vault_id.class

        current_key = LockSmith::SymmetricKey.new(vault_id: vault_id, rbnacl_key: active_key)
        vault = LockSmith::SymmetricVault.new(vault_string)
        vault.add_object(current_key.as_json).unlock
      end
    end

    def log
      @log ||= ''
    end

    private
    attr_reader :contract_password
    attr_accessor :active_key


    def vault_collection
      @vault_collection ||= LockSmith::VaultCollection.new(string)
    end

    def no_contract_key
      raise 'Expecteding a contract key to get the ball rolling'
    end
  end
end
