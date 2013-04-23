require 'jbuilder'
require 'digest/sha1'
require 'rbnacl'

describe 'Vault' do
  describe '#clear_text' do

    before :each do
      @first_id = Id.new('123456')
      @second_id = Id.new('654321')
      @expected_clear_text = %Q[{"vault":[{"id":"123456"},{"id":"654321"}]}]
      @actual_clear_text =  Vault.new(content: [@first_id, @second_id]).clear_text
      @expected_sha1 = Digest::SHA1.hexdigest(@expected_clear_text)
      @actual_sha1 = Digest::SHA1.hexdigest(@actual_clear_text)
      @file = File.new("#{Dir.pwd}/test.json", "w+")
    end

    it 'it returns unencrypted complex values JSON' do
      @actual_clear_text.should == @actual_clear_text 
    end

    it 'the checksums should equal out' do
      @expected_sha1.should == @actual_sha1 
    end
  
    it 'it writes the correct values to a file' do
      File.open(@file, 'w') { |file| file.write("#{@actual_clear_text}")}
    end
  end
end

describe 'Vault' do
  describe 'cipher_text' do
    before :all do
      @first_id = Id.new('123456')
      @second_id = Id.new('654321')
      @expected_clear_text = %Q[{"vault":[{"id":"123456"},{"id":"654321"}]}] 
      @clear_text_sha1 = Digest::SHA1.hexdigest(@expected_clear_text)
      @vault =  Vault.new(content: [@first_id, @second_id])
      @cipher_text = @vault.cipher_text
    end

    it 'the encrypted text is a string' do
      @cipher_text.kind_of?(String).should == true
    end

    it 'it writes the encrypted values to a file' do
      @file = File.new("#{Dir.pwd}/test.json", "w+")
      File.open(@file, 'w') { |file| file.write("#{@cipher_text}")}
    end

    it 'the hash of the cipher text differs from the clear text' do
      puts @cipher_text
      puts Digest::SHA1.hexdigest(@cipher_text)
      puts @clear_text_sha1
      Digest::SHA1.hexdigest(@cipher_text).should_not == @clear_text_sha1
    end

  end
end
