module Downloads
  module Commands
    class Help < Base
      def run
        puts 'Usage: downloads <command> [options]'
        puts 'Available commands are:'
        Commands.registry.keys.sort.each { |name| puts " - #{name}" }
      end
    end
  end
end
