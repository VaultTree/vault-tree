module VaultTree
  class OneTwoThree < Template

    def template_erb
      %Q[
        {
          "<%= vault_3.id.color(:green) %>":"<%= construct_vault_3.lock%>",
          "<%= vault_2.id.color(:green) %>":"<%= construct_vault_2.lock%>",
          "<%= vault_1.id.color(:green) %>":"<%= construct_vault_1.lock%>"
        }
      ]
    end

    def construct_vault_3
      vault_3.add_object(key_3_json)
    end

    def construct_vault_2
      vault_2.add_object(key_3_json)
      vault_2.add_object(key_2_json)
    end

    def construct_vault_1
      vault_1.add_object(key_2_json)
      vault_1.add_object(key_1_json)
    end
    
    def vault_1
      @v1 ||= LockSmith::SymmetricVault.new
    end

    def vault_2
      @v2 ||= LockSmith::SymmetricVault.new
    end

    def vault_3
      @v3 ||= LockSmith::SymmetricVault.new
    end

    def key_1_json
      @k1 ||= LockSmith::SymmetricKey.new(vault_id: vault_1.id)
      @k1.as_json
    end

    def key_2_json
      @k2 ||= LockSmith::SymmetricKey.new(vault_id: vault_2.id)
      @k2.as_json
    end

    def key_3_json
      @k3 ||= LockSmith::SymmetricKey.new(vault_id: vault_3.id)
      @k3.as_json
    end
  end
end
