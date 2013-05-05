load File.dirname(__FILE__) + '/../lib/cc-engine.rb'
load File.dirname(__FILE__) + '/../lib/vault-tree.rb'
require 'uuidtools'
require 'active_support'
require 'digest/sha1'
require 'rspec_encoding_matchers'


RSpec.configure do |config|
  config.color_enabled = true
  config.include RSpecEncodingMatchers
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end

class String
  def compress
    gsub("\n", ' ').squeeze(' ').strip
  end
end

module Fixtures

  def self.wallet_address
    %Q[{"class":"wallet_address",
        "description":"Fixture Wallet Address",
        "value":"ADDRESS"}].compress
  end

  def self.wallet_address_alt
    %Q[{"class":"wallet_address_alt",
        "description":"Alternate Fixture Wallet Address",
        "value":"ADDRESS_ALT"}].compress
  end

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

  def self.symmetric_vault
    %Q[
      {"object":"symmetric_vault","state":{}} 
    ].compress
  end

def self.one_two_three_encrypted
  %Q[
{
          "98f26f8d-8ad2-43c4-b19b-af99128422f8":"2ogep64ywkgu6jpxpi34nzwsa44v642yvrlvw57erptw3skwkqiwtcn46ctfvdokjhr5pjm7jdsl6js5dconbds2f3i62pgsceorkzyxytqspi5gfggbohzco3ke3ckfv53dunyeonssvenogfkrjeaknqrzcsevrz3sacfvdktowpuwkszhfzxd5dfnqnolwne6eusps34tnc7uccbvqeyb63tgc2wvolzxvvhq4cl4are42q46zxfrta326uk7c24pcd4mpzb4cdpfk3pyf33w6puluucr2bn6s4wsptsqeseub6dkk2phhd6bydwaqpo7edyizdqanslgi7gfyv5b2mlmeja2lhbegnwr3rycc6zas3c2ynqzn6bnos2kscphkfil75m5ocy6jlbmurbrtlbb6ewoav3x7id2rffci===",
          "8000d8b1-63bb-461c-ab6a-c877758f1766":"f7e3p25ih2jx5c4nq3a64tqsw3ekhqj7rcjtiam7v5uwvuoq565c7af5oh6xw2bbejsulccsplnc4ofcacvur6kom4nroxof2jv6jlmbgix7tda3dphtndi7kjtpsugwdfmptdbuv37yi3gnwhait4sgopcwjft2flixmmfagbo27yh3jgzotc4iqipumfxev2nogo5ffdbkwy4xv7whgzzn7szzpccknpxvajgzy7s4s5v2y2zddal4abitsvjmuf65yvsoonjkfo6nujd6iikcalumdstp2mwet46mw4vfuh5o2u7pdudgvbtrrxxycyqo6kda3lkxytggwhkghdgb5biuzhmciw5yf63omdpqa3tejqjsmd4xookpolqh7ghs5fgomfdksnpjzvsd7xqefed2ttnu5q66izchh6otspt55cd4tcatgynvodygmr4q3554pdroqmgyrtiywzkumpnc7g2pkarqa6x3xsvleibyuh3zdlcqz6veryemi2b5red52hcgdyoo7uxfmixdtdf2tofbq36v3lj5wvbnohhiww5skihhzz7iz7jbqtqpxrubqppue6q7y5bqaqeje2m35lbawc7m53mnpy3dyor47z3znx2nh2khzi3y7k5akb6hjnmlu3zyibplu3ptvqms2qh25w3a====",
          "78dd0570-24a7-4404-947c-d3f60e010aea":"izj2ty52mx6y7ov7daasgr5jjflw3fadu7dki2cf22seepmqxeqkskbcjyy3xt6nw3ezcjjs42f6d6ltvoxqo5c4l5x674ty2yxdczj2aout3ewvhlbtxl3xv4s5k4kl7yunzoxamarup3abttba44cmbfy23wyjuutwgmir23y4cfmwgtttrrqrgbseoitcwa4wqkctnnsuluhmkzk3zlap22qofwoeoqdcc6z36quth2ykqldauljofxknvaqw2h4lragjmxqtxefyuxtzmhplueykqq5d7sig3lpuqefgd5gu5yblhihbqplunehdunxr75zhcau7lnvttdfqvhflcvkavsnu5dksnkplg6ktxlch777ardhyr2xre4xu4fvrdwzgbdkwdab4nkn5wsbokd3shityv3p6sbsykcr7sdqf3htb4nzolcmehchzsusjfpv3jynjlkmzpw64m4ufbyvhmcmogjrfhhvmgiaghsk4ymx6k7gxjq7ccny3yybphhwqwz52z5ypewuwx75ewr7d3vyo4zyp2rgsoaqcj526nh5ggkn7fmqgqpp2zatqa3lahemzu7jxy7nk4kui5eppqjckyhgft7znug4a7oh2o4clqlgjhqaxcmmj53mfgbeq4mfajkh5t5bsmifkuiecfnvzwe6a===="
        }].compress
end

end
