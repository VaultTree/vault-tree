module VaultTree
  class OneTwoThree < Template

    def template_erb
      %Q[
        {
          "<%= vault_3.id %>":"<%= vault_3.lock%>",
          "<%= vault_2.id %>":"<%= vault_2.lock%>",
          "<%= vault_1.id %>":"<%= vault_1.lock%>"
        }
      ]
    end

    def vault_1
      json = "{}"
      #LockSmith::SymmetricVault.new(json)
    end

    def vault_2
      json = "{}"
      #LockSmith::SymmetricVault.new(json)
    end

    def vault_3
      vault_id = generate_uuid
      vault_key = %Q[
        {
          "class":"symmetric_key",
          "description":"Symmetric Key for Vault: #{vault_id}",
          "id":"#{vault_id_checksum(vault_id)}"
          "key":""
        }
      ]
      puts vault_key 
      #LockSmith::SymmetricVault.new(json)
    end

  end
end
