module VaultTree
  class Escrow < Template

    def template_erb
      %Q[
        {
          "<%= uuid %>":"<%= seller_step_1%>",
          "<%= uuid %>":"<%= seller_step_2%>",
          "<%= uuid %>":"<%= seller_step_3%>",
          "<%= uuid %>":"<%= seller_step_4%>",
          "<%= uuid %>":"<%= buyer_step_1%>",
          "<%= uuid %>":"<%= buyer_step_2%>",
          "<%= uuid %>":"<%= buyer_step_3%>",
          "<%= uuid %>":"<%= buyer_step_4%>"
        }
      ]
    end

    def seller_step_1
      'ENCRYPTED_S1'
    end

    def seller_step_2
      'ENCRYPTED_S2'
    end

    def seller_step_3
      'ENCRYPTED_S3'
    end

    def seller_step_4
      'ENCRYPTED_S4'
    end

    def buyer_step_1
      'ENCRYPTED_B1'
    end

    def buyer_step_2
      'ENCRYPTED_B2'
    end

    def buyer_step_3
      'ENCRYPTED_B3'
    end

    def buyer_step_4
      'ENCRYPTED_B4'
    end

  end
end
