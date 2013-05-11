class CreateModels < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :content
      t.boolean :published, default: false
    end

    create_table :contracts do |t|
    end

    create_table :contract_headers do |t|
    end

    create_table :genesis_vaults do |t|
    end

    create_table :symmetric_vaults do |t|
      t.text :contents, default: nil
      t.text :encrypted_contents, default: nil
      t.boolean :open, default: false
    end

    create_table :asymmetric_vaults do |t|
    end

  end
end
