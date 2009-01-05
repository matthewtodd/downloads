module Downloads
  module Commands
    class Rm < Base
      attr_accessor :filenames

      def self.usage
        "#{super} FILE ..."
      end

      def configure(argv)
        self.filenames = []
        while filename = shift_argument(argv)
          self.filenames << filename
        end
      end

      def run
        remote.run("rm '#{filenames.join("' '")}'")
      end

      def valid?
        filenames.any?
      end
    end
  end
end
