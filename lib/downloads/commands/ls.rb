module Downloads
  module Commands
    class Ls < Base
      def run
        remote.files.each { |file| puts file[:name] }
      end
    end
  end
end
