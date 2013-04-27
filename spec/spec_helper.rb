load File.dirname(__FILE__) + '/../lib/cc-engine.rb'
require 'factory_girl'

class String
  def compress
    gsub("\n", ' ').squeeze(' ').strip
  end
end


module Fixtures

  def self.valid_vault_collection
    %Q[
      {"#{valid_vault_id}":"#{valid_vault}","#{valid_vault_id_alt}":"#{valid_vault_alt}"}
    ].compress
  end

  def self.valid_vault
    "ENCRYPTED_CONTENTS"
  end

  def self.valid_vault_alt
    "ENCRYPTED_CONTENTS_ALT"
  end

  def self.valid_vault_id
    "VALID_VAULT_ID"
  end

  def self.valid_vault_id_alt
    "VALID_VAULT_ID_ALT"
  end

  def self.invalid_vault_id
    "INVALID_VAULT_ID"
  end

  def self.id
    %Q[{"object":"id","state":123456}].compress
  end

  def self.id_alt
    %Q[
      {"object":"id","state":654321}
    ].compress
  end

  def self.map
    %Q[
      {"object":"map","state":{"description":"https://about.info"}}
    ].compress
  end

  def self.vault_rack
    %Q[
      {"object":"vault_rack","state":[#{id},#{id}]}
    ].compress
  end

  def self.vault_rack_alt
    %Q[
      {"object":"vault_rack","state":[#{id},#{id_alt}]}
    ].compress
  end

  def self.vault_rack_mixed
    %Q[
      {"object":"vault_rack","state":[#{id},#{map}]}
    ].compress
  end

  def self.symmetric_vault
    %Q[
      {"object":"symmetric_vault","state":#{vault_rack}} 
    ].compress
  end
end
