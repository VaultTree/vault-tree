require 'jbuilder'
require 'digest/sha1'

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

class Vault
  attr_reader :content

  def initialize(opts = {} )
    @content = opts[:content]
  end

  def clear_text 
    jbuilder_clear_text.target!
  end

  def jbuilder_clear_text
    Jbuilder.new do |json|
      json.vault content, :id
    end
  end
end

class Id
  attr_reader :id
  def initialize(id)
    @id = id
  end

  def jbuilder_clear_text
    Jbuilder.new do |json|
      json.id id
    end
  end

  def clear_text 
    jbuilder_clear_text.target!
  end
end
