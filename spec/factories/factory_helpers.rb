module FactoryHelpers
  def self.random_hex
    (0...4).map{ ('a'..'z').to_a[rand(26)] }.join
  end
end

FactoryGirl.define do
  sequence(:random_hex) {FactoryHelpers.random_hex}
end
