module VaultTree
  module Exceptions
    class LibraryException < StandardError
      attr_reader :original_exception

      def initialize(original_exception = nil, runtime_information = {})
        @original_exception = original_exception
        post_initialize(runtime_information)
      end

      def post_initialize(opts)
        nil
      end

      def runtime_information
        {}
      end

      def exception
        self
      end

      def message
        output_exception_message
      end

      def background
        nil
      end

      def troubleshooting_questions
        nil
      end

      def name
        self.class
      end

      private

      def output_exception_message
        STDOUT.write(full_exception_message)
      end

      def full_exception_message
        %Q{
          #{message_banner}
          #{name}
          #{message_banner}
          #{present_runtime_information}
        }
      end

      def message_banner
        %Q{####################################################}
      end

      def present_runtime_information
        "#{runtime_information}" unless runtime_information.empty?
      end

    end
  end
end
