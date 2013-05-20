module VaultTree
  class Api
    def export_contract(opts ={})
      c = Contract.where(name: opts[:name])
      puts c.as_json
    end
  end
end
