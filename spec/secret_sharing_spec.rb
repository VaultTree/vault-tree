require 'rspec'
RSpec.configure{ |config| config.color_enabled = true }
require 'secretsharing'

describe 'Secret Sharing Test Run' do
  describe 'from the README' do

    it 'demo the gem use' do

      # create an object for 3 out of 5 secret sharing
      s = SecretSharing::Shamir.new(5,3)

      # create a random secret (returns the secret)
      s.create_random_secret

      # show secret
      #puts s.secret
      created_secret = s.secret

      # show password representation of secret (Base64)
      #puts s.secret_password

      # show shares
      #s.shares.each { |share| puts share }

      # recover secret from shares
      s2 = SecretSharing::Shamir.new(3)

      # Accepts SecretSharing::Shamir::Share objects or
      # string representations thereof

      # In this case we are useing the string representation
      s2 << s.shares[0].to_s
      s2 << s.shares[2].to_s
      s2 << s.shares[4].to_s
      assembled_secret = s2.secret
      #puts assembled_secret

      #Compare assembled to created
      assembled_secret.should == created_secret
    end
  end
end