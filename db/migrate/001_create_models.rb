class CreateModels < ActiveRecord::Migration
  def change
    create_table :enforcers do |t|
      t.integer :contract_id
    end

    create_table :symmetric_vaults do |t|
      t.integer :enforcer_id
    end

    create_table :asymmetric_vaults do |t|
      t.integer :enforcer_id
    end

    create_table :contracts do |t|
      t.text :content
    end

    create_table :contract_headers do |t|
      t.integer :contract_id
      t.text :contract_vault_id
      t.text :content
    end

    create_table :vaults do |t|
      t.integer :contract_id
      t.text :content
    end
  end
end
