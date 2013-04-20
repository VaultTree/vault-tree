require 'spec_helper'

module LockSmith
  describe 'Rack' do
    describe '#same_as?' do
      before :all do
        same_array = [LockSmith::Id.new('123456'), LockSmith::Id.new('654321')]
        diff_array = [LockSmith::Id.new('123456'), LockSmith::Id.new('987656')]
        @first_rack = LockSmith::Rack.new(contents: same_array)
        @second_rack = LockSmith::Rack.new(contents: same_array)
        @different_rack = LockSmith::Rack.new(contents: diff_array)
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
