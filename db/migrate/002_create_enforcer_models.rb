class CreateEnforcerModels < ActiveRecord::Migration
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
  end
end
