class CreateContractModels < ActiveRecord::Migration
  def change

    create_table :contracts do |t|
      t.text :specification
    end

    create_table :parties do |t|
      t.integer :contract_id
      t.integer :party_number
      t.text :public_key
      t.text :bit_message_address
      t.text :affirmation_key
      t.text :contract_signature
    end

    # use in model: alias_attribute :subject, :title
    create_table :vaults do |t|
      t.integer :contract_id
      t.integer :party_id
      t.text :label
      t.text :unlocking_certificate
      t.text :custodian_signature
      t.text :desc
      t.text :content
    end
  end
end
