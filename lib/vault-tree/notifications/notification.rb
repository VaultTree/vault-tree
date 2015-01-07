module VaultTree
  module Notifications
    class Notification < StandardError

      def initialize(runtime_information = {})
        post_initialize(runtime_information)
      end

      def post_initialize(opts)
        nil
      end

      def runtime_information
        {}
      end

      def notify
        STDOUT.write(runtime_information)
      end

    end
  end
end
