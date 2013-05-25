class CreateContractModels < ActiveRecord::Migration
  def change

    create_table :contracts do |t|
      t.text :specification
      t.text :checksum
    end

    create_table :parties do |t|
      t.integer :contract_id
      t.text :number
      t.text :public_key
      t.text :address
      t.text :affirmation_key
      t.text :contract_signature
    end

    create_table :vaults do |t|
      t.integer :contract_id
      t.text :label
      t.text :custodian_number
      t.text :custodian_signature
      t.text :unlocking_certificate
      t.text :content
      t.text :desc
    end

    create_table :signature_blocks do |t|
      t.integer :contract_id
      t.text :party_number
      t.text :affirmation_key
      t.text :signature
    end

  end
end
