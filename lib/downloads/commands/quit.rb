module Downloads
  module Commands
    class Quit < Base
      def run
        puts 'Goodbye.'
        exit
      end
    end
  end
end
