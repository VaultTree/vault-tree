module VaultTree
  module V2
    class Contract
      attr_reader :json, :contract

      def initialize(opts)
        @json = opts[:json]
        @contract = Support::JSON.decode(json) 
      end

      def private_data_present?(party_id)
         blank_private_data_values(party_id).empty?
      end

      def public_data_present?(party_id)
        blank_public_data_values(party_id).empty?
      end

      def public_data(party_id) 
        contract['parties'][party_id]['public_data']
      end

      def private_data(party_id) 
        contract['parties'][party_id]['private_data']
      end

      def write_public_data_for_party(party_id, public_data)
        @contract['parties'][party_id]['public_data'] = public_data
      end

      def write_private_data_for_party(party_id, private_data)
        @contract['parties'][party_id]['private_data'] = private_data
      end

      private

      def blank_public_data_values(party_id)
        public_data_values(party_id).select{|pdv| pdv.empty?} 
      end

      def blank_private_data_values(party_id)
        private_data_values(party_id).select{|pdv| pdv.empty?} 
      end

      def public_data_values(party_id) 
        public_data(party_id).values
      end

      def private_data_values(party_id) 
        private_data(party_id).values
      end
    end
  end
end
