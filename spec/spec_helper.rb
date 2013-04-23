load File.dirname(__FILE__) + '/../lib/cc-engine.rb'
require 'factory_girl'


class String
  def compress
    gsub("\n", ' ').squeeze(' ').strip
  end
end


module Fixtures

  def self.id
    %Q[
      {"object":"id","state":123456}
    ].compress
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
