module Downloads
  module Commands
    class Complete < Base
      def run
        line = ENV['COMP_LINE']
        args = line.split(/\s+/)
        args.shift

        position = args.length + (line.match(/\s$/) ? 1 : 0)
        case position
        when 1
          puts Commands.registry.keys.sort.grep(/^#{args.first}/)
        else
          puts ''
        end
      end
    end
  end
end
