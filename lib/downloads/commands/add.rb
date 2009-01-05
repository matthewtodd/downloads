require 'uri'

module Downloads
  module Commands
    class Add < Base
      attr_accessor :uris

      def banner
        "#{super} <url> [url...]"
      end

      def configure(argv)
        self.uris = []
        while uri = URI.parse(shift_argument(argv))
          self.uris << uri
        end
      end

      def run
        remote.run("wget '#{uris.join("' '")}' --no-check-certificate")
      end

      def valid?
        uri
      end
    end
  end
end
