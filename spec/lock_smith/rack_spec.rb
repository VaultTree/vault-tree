require 'spec_helper'

module LockSmith
  describe 'Rack' do
    describe '#as_json' do
      before :all do
        @rack = Rack.new(Fixtures.vault_rack)
      end

      it 'returns the expected json' do
        @rack.as_json.should == Fixtures.vault_rack 
      end

      it 'the checksums match' do
        act = Digest::SHA1.hexdigest(@rack.as_json)
        exp = Digest::SHA1.hexdigest(Fixtures.vault_rack)
        act.should == exp
      end

      it 'json looks correct on a file' do
        f = File.new("#{Dir.pwd}/test.json", "w+")
        File.open(f, 'w') { |file| file.write("#{@rack.as_json}")}
      end
    end

    describe '#contents' do
      before :all do
        @rack = Rack.new(Fixtures.vault_rack_mixed)
      end

      it 'returns an array' do
        @rack.contents.should be_an_instance_of(Array)
      end

      it 'the first item is an Id object' do
        @rack.contents.first.should be_an_instance_of(Id)
      end

      it 'the last item is a Map object' do
        @rack.contents.last.should be_an_instance_of(Map)
      end
    end

    describe '#same_as?' do
      before :all do
        @first_rack = LockSmith::Rack.new(Fixtures.vault_rack)
        @second_rack = LockSmith::Rack.new(Fixtures.vault_rack)
        @different_rack = LockSmith::Rack.new(Fixtures.vault_rack_alt)
      end

      it 'returns true if the contents strings are the same' do
        @first_rack.same_as?(@second_rack).should == true
        @second_rack.same_as?(@first_rack).should == true
      end

      it 'returns false if the contents strings are the different' do
        @first_rack.same_as?(@different_rack).should == false
        @different_rack.same_as?(@first_rack).should == false
      end
    end
  end 
end
