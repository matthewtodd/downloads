require 'uri'

module Downloads
  module Commands
    class Add < Base
      attr_accessor :uris

      def self.usage
        "#{super} URL ..."
      end

      def configure(argv)
        self.uris = []
        while uri = shift_argument(argv)
          self.uris << URI.parse(uri)
        end
      end

      def run
        remote.run("wget '#{uris.join("' '")}' --no-check-certificate")
      end

      def valid?
        uris.any?
      end
    end
  end
end
