require 'spec_helper'

module VaultTree
  describe 'Template' do
    describe '#genrate_contract' do

      before :each do
        @mock_template = MockTemplate.new 
      end

      it 'returns as string' do
        puts @mock_template.generate_contract
        @mock_template.generate_contract.should be_an_instance_of(String)
      end

      it 'returns the correct values' do
        MultiJson.load(@mock_template.generate_contract).values.first.should == 'ENCRYPTED_1'
        MultiJson.load(@mock_template.generate_contract).values.last.should == 'ENCRYPTED_4'
      end
    end
  end
end

require 'erb'

module VaultTree
  class Template
    def initialize
      post_initialize
    end

    def post_initialize
      nil
    end

    def generate_contract
      ERB.new(template_erb).result(binding)
    end

    def uuid
      "MOCK_UUID"
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
          "<%= uuid %>_1":"<%= seller_step_1%>",
          "<%= uuid %>_2":"<%= seller_step_2%>",
          "<%= uuid %>_3":"<%= buyer_step_1%>",
          "<%= uuid %>_4":"<%= buyer_step_2%>"
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

