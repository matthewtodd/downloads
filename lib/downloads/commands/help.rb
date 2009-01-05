module Downloads
  module Commands
    class Help < Base
      attr_accessor :command

      def self.usage
        "#{super} [COMMAND]"
      end

      def configure(argv)
        self.command = shift_argument(argv)
      end

      def run
        if command
          puts Commands.registry[command].usage
        else
          puts Commands.objects.map { |command| command.usage }
        end
      end
    end
  end
end
