class CreateContractModels < ActiveRecord::Migration
  def change

    create_table :contracts do |t|
    end

    create_table :headers do |t|
      t.integer :contract_id
      t.text :specification
      t.text :checksum
    end

    create_table :parties do |t|
      t.integer :contract_id
      t.text :label
      t.text :address
      t.text :verification_key
      t.text :public_encryption_key
      t.text :contract_consent_key
    end

    create_table :vaults do |t|
      t.integer :contract_id
      t.text :label
      t.text :custodian
      t.text :unlocking_certificate
      t.text :content_certificate
      t.text :content
      t.text :signed_vault_content
      t.text :desc
    end

    create_table :signature_blocks do |t|
      t.integer :contract_id
      t.text :party_label
      t.text :signed_label
      t.text :signed_address
      t.text :signed_verification_key
      t.text :signed_public_encryption_key
      t.text :signed_contract_consent_key
    end

  end
end
