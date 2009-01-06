module Downloads
  module Commands
    class Ls < Base
      def run
        puts remote.filenames
      end
    end
  end
end
