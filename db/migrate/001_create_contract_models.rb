class CreateContractModels < ActiveRecord::Migration
  def change

    create_table :contracts do |t|
      t.text :content
    end

    create_table :contract_headers do |t|
      t.integer :contract_id
      t.text :content
    end

    create_table :nodes do |t|
      t.text :label
      t.text :content
      t.integer :contract_id
    end

    create_table :vaults do |t|
      t.integer :node_id
      t.text :content
    end

    create_table :unlocking_conditions do |t|
      t.integer :vault_id
      t.text :content
    end

    create_table :unlocking_certificates do |t|
      t.integer :unlocking_condition_id
      t.text :content
    end
  end
end
