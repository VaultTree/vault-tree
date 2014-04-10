module VaultTree
  module Exceptions
    class LibraryException < StandardError
      attr_reader :original_exception

      def initialize(original_exception = nil, opts = {})
        @original_exception = original_exception
      end

      def exception
        output_exception_message
        self
      end

      def summary
        nil
      end

      def search_word
        nil
      end

      def background
        nil
      end

      def troubleshooting_questions
        nil
      end

      def name
        nil
      end

      private

      def output_exception_message
        STDOUT.write(full_exception_message)
      end

      def full_exception_message
        %Q{
          #{message_banner}
          #{present_name}
          #{present_search_word}
          #{message_banner}
          #{present_summary}
          #{present_background}
          #{present_troubleshooting}
          #{present_original_exception_class}
          #{present_original_exception_message}
          #{present_original_backtrace}
          #{message_banner}
        }
      end

      def message_banner
        %Q{####################################################}
      end

      def present_name
        "Vault Tree Exception: #{name}"
      end

      def present_search_word
        "Search For: #{search_word}" unless search_word.nil?
      end

      def present_summary
        %Q{Here is what went wrong:
            #{summary}
        } unless summary.nil?
      end

      def present_troubleshooting
        %Q{Troubleshooting Questions To Ask:
            #{troubleshooting_questions}
        } unless troubleshooting_questions.nil?
      end

      def present_background
        %Q{Background Info:
            #{background}
        } unless background.nil?
      end

      def present_original_exception_class
        %Q{Original Exception Class:
            #{original_exception.class}
         } unless original_exception.nil?
      end

      def present_original_exception_message
        %Q{Original Exception Message:
            #{original_exception.message}
         } unless original_exception.nil?
      end

      def present_original_backtrace
        %Q{Original Exception Backtrace:
            #{original_exception.backtrace.join("\n")}
         } unless original_exception.nil?
      end
    end
  end
end
