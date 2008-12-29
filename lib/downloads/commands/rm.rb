module Downloads
  module Commands
    class Rm < Base
      attr_accessor :filename

      def banner
        "#{super} <filename>"
      end

      def configure(argv)
        self.filename = shift_argument(argv)
      end

      def run
        remote.run("rm '#{filename}'")
      end

      def valid?
        filename
      end
    end
  end
end
