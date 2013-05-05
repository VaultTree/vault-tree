require 'spec_helper'
module VaultTree 
  describe 'Contract' do
    describe '#enforce' do
      before :each do
        json = Fixtures.one_two_three
        @contract = Contract.new(json)
      end

      it 'pends' do
        pending 'Not Implemented'
      end

      it 'pends' do
        pending 'Not Implemented'
      end
    end
  end
end

module VaultTree
  class Contract
    attr_reader :string

    def initialize(json)
      @string = json
    end

    def enforce
      puts "Enforcing with this json: #{string}"
    end

    def log
    end
  end
end
