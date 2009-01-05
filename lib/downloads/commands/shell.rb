module Downloads
  module Commands
    class Shell < Base
      def run
        loop do
          print "> "
          command = Downloads::Commands.lookup(gets.split(' '))
          command.run if command.valid?
        end
      end
    end
  end
end
