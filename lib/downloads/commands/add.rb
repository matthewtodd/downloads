require 'uri'

module Downloads
  module Commands
    class Add < Base
      attr_accessor :uri

      def banner
        "#{super} <url>"
      end

      def configure(argv)
        self.uri = URI.parse(shift_argument(argv))
      end

      def run
        remote.run("wget '#{uri}' --no-check-certificate")
      end

      def valid?
        uri
      end
    end
  end
end
