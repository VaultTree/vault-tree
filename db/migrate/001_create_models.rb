class CreateModels < ActiveRecord::Migration
  def change

    create_table :enforcers do |t|
    end

    create_table :contracts do |t|
    end

    create_table :contract_headers do |t|
      t.integer :contract_id
      t.text :content
    end

    create_table :genesis_vaults do |t|
      t.integer :contract_id
      t.text :content
    end

    create_table :symmetric_vaults do |t|
      t.text :content, default: nil
      t.text :encrypted_contents, default: nil
      t.boolean :open, default: false
    end

    create_table :asymmetric_vaults do |t|
    end

    create_table :vaults do |t|
      t.integer :contract_id
      t.text :content
    end
  end
end
