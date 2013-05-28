module VaultTree
  module V1
    extend self

    # Exaustive check to ensure contract integrity
    #  This method will run before every API call without exception.
    #
    #  Note that this method is concerned with only the integrity of the
    #  input contract, not the options that happened to be passed with
    #  a particular API call. Options validation will occur at a later point.
    # 
    #  To include checks for:
    #  * Proper JSON Format
    #  * White listed syntax
    #  * Valid String Encoding
    #  * Valid Vault Signatures
    #  * Valid Contract Signatures if present
    # @param contract [String] the input contract
    # @return [String] The output contract. 
    def certify_contract(contract_json)
      #Work in progress
      contract_json
    end

    # Sets the respective party's signature verification key.
    #
    # @param contract [String] the input contract
    # @param [Hash] Required Options
    # @option opts [String] :party_number
    #   The number associated with the particular party.
    #   This must be a positive integer passed as a string. Example: '1','2','5'
    # @option opts [String] :signature_key Digital Signature Verification Key
    #   In the real world, signatures help uniquely identify people because everyone's signature
    #   is unique. Digital signatures work similarly in that they are unique to holders of a
    #   private key, but unlike real world signatures, digital signatures are unforgable.
    #
    #   Digital signatures allow you to publish a public key, then you can use your
    #   private signing key to sign messages. Others who have your public key can then
    #   use it to validate that your messages are actually authentic.
    # @option opts [String] :encryption_key
    # 
    #   Imagine Alice wants something valuable shipped to her. Because it's valuable, she wants
    #   to make sure it arrives securely (i.e. hasn't been opened or tampered with) and that
    #   it's not a forgery (i.e. it's actually from the sender she's expecting it to be from
    #   and nobody's pulling the old switcheroo)
    #
    #   One way she can do this is by providing the sender (let's call him Bob) with a high-security
    #   box of her choosing. She provides Bob with this box, and something else: a padlock, but a padlock
    #   without a key. Alice is keeping that key all to herself. Bob can put items in the box then put the
    #   padlock onto it, but once the padlock snaps shut, the box cannot be opened by anyone who doesn't
    #   have Alice's private key.
    #
    #   Here's the twist though, Bob also puts a padlock onto the box. This padlock uses a key Bob has
    #   published to the world, such that if you have one of Bob's keys, you know a box came from him
    #   because Bob's keys will open Bob's padlocks (let's imagine a world where padlocks cannot be forged
    #   even if you know the key). Bob then sends the box to Alice.
    #
    #   In order for Alice to open the box, she needs two keys: her private key that opens her own padlock,
    #   and Bob's well-known key. If Bob's key doesn't open the second padlock then Alice knows that this is
    #   not the box she was expecting from Bob, it's a forgery.
    #
    #   This bidirectional guarantee around identity is known as mutual authentication.
    # @return [String] The output contract
    def set_public_keys(contract_json, opts)
      filter(contract_json, opts)
    end


  end
end
