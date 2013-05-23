module VaultTree
  class Api
    def export_contract(opts ={})
      c = Contract.where(name: opts[:name])
      file_name = 'one_two_three.json'
      File.open("#{PathHelpers.contracts_dir}/#{file_name}", 'w') do |file|
        file.write(c.as_json)
      end 
    end
  end
end
