require 'spec_helper'

module VaultTree
  describe 'Contract' do
    describe '.import | #as_json' do
      before(:each) do
        @json = File.open(PathHelpers.one_two_three_contract).read
        @contract = Contract.import(@json)
      end

      it 'the normalized inputs matches the normalized output' do
        @contract.as_json.normalized.should == @json.normalized
      end

      it 'the normalized string checksums should match' do
        @contract.as_json.normalized.checksum.should == @json.normalized.checksum
      end
    end

    describe '.import' do
      context 'with an valid contract' do
        before(:each) do
          @json = File.open(PathHelpers.one_two_three_contract).read
          @contract = Contract.import(@json)
        end

        it 'returns a contract object' do
          @contract.should be_an_instance_of(Contract)
        end

        it 'the contract has been properly save' do
          @contract.persisted?.should be true
        end
      end

      context 'with an invalid contract' do
        context 'mal formed json' do

          before(:each) do
            @json = File.open(PathHelpers.mal_formed_json_contract).read
            @contract = Contract.import(@json)
          end

          it 'returns a NullContract' do
            @contract.should be_an_instance_of(NullContract)
          end

          it 'the NullContract responds to as_json and returns a string' do
            @contract.as_json.should be_an_instance_of(String)
          end

          it 'the NullContract.as_json returns the proper string' do
            @contract.as_json.should =~ /Malformed JSON/
          end
        end
      end
    end

    describe '#create' do

      before(:each) do
        @contract = FactoryGirl.create(:contract)
      end

      it 'has_one header' do
        @contract.header.should be_an_instance_of(Header)
      end

      it 'has_many vaults' do
        @contract.vaults.length.should be > 1
      end

      it 'can access its vaults' do
        @contract.vaults.first.should be_an_instance_of(Vault)
      end

      it 'each vault is different' do
        f = @contract.vaults.first.label
        l = @contract.vaults.last.label
        f.should_not == l
      end

      it 'has_many parties' do
        @contract.parties.length.should be > 1
      end

      it 'can access its parties' do
        @contract.parties.first.should be_an_instance_of(Party)
      end

      it 'each party is different' do
        f = @contract.parties.first
        l = @contract.parties.last
        f.should_not == l
      end

      it 'has_many signature blocks' do
        @contract.signature_blocks.length.should be > 1
      end

      it 'can access its signature blocks' do
        @contract.signature_blocks.first.should be_an_instance_of(SignatureBlock)
      end

      it 'each sig block is different' do
        f = @contract.signature_blocks.first
        l = @contract.signature_blocks.last
        f.should_not == l
      end
    end
  end
end
