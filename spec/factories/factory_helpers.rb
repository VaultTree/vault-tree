module FactoryHelpers
  extend self

  def random_hex
    (0...4).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  def random_int
    rand(100)
  end

  def int
    self.random_int
  end

  def vault_label
    "[#{int},#{int},#{int}]"
  end
end

FactoryGirl.define do
  sequence(:random_hex) {FactoryHelpers.random_hex}
end
