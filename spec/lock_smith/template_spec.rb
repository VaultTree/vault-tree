require 'spec_helper'

module VaultTree
  describe 'Template' do
    describe '#genrate_contract' do

      before :each do
        @mock_template = MockTemplate.new 
      end

      it 'returns as string' do
        @mock_template.generate_contract.should be_an_instance_of(String)
      end

      it 'returns the correct values' do
        MultiJson.load(@mock_template.generate_contract).values.first.should == 'ENCRYPTED_1'
        MultiJson.load(@mock_template.generate_contract).values.last.should == 'ENCRYPTED_4'
      end
    end
  end
end

module VaultTree
  class MockTemplate < Template

    def post_initialize
      nil
    end

    def template_erb
      %Q[
        {
          "<%= generate_uuid %>_1":"<%= seller_step_1%>",
          "<%= generate_uuid %>_2":"<%= seller_step_2%>",
          "<%= generate_uuid %>_3":"<%= buyer_step_1%>",
          "<%= generate_uuid %>_4":"<%= buyer_step_2%>"
        }
      ]
    end

    def seller_step_1
      'ENCRYPTED_1'
    end

    def seller_step_2
      'ENCRYPTED_2'
    end

    def buyer_step_1
      'ENCRYPTED_3'
    end

    def buyer_step_2
      'ENCRYPTED_4'
    end
  end
end
