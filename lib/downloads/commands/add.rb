require 'uri'

module Downloads
  module Commands
    class Add < Base
      attr_accessor :uri, :filename

      def banner
        "#{super} <url> [-O FILENAME]"
      end

      def configure(argv)
        self.uri = URI.parse(shift_argument)

        options.on('-O', '--output-document FILENAME', 'Save download as FILENAME') do |filename|
          self.filename = filename
        end
      end

      def run
        if filename
          remote.run("wget '#{uri}' -O '#{filename}'")
        else
          remote.run("wget '#{uri}'")
        end
      end

      def valid?
        uri
      end
    end
  end
end
