require 'open-uri'
require 'hpricot'

# TODO could remove duplication with Add command, perhaps by seeing this as a filter of sorts...
module Downloads
  module Commands
    class Video < Base
      attr_accessor :uris

      def self.usage
        "#{super} URL ..."
      end

      def configure(argv)
        self.uris = []
        while uri = shift_argument(argv)
          self.uris << parse_uri(uri)
        end
      end

      def run
        remote.run("wget '#{download_uris.join("' '")}' --no-check-certificate")
      end

      def valid?
        download_uris.any?
      end

      private

      def download_uris
        @download_uris ||= uris.map do |uri|
          open(keepvid(uri)) { |stream| Hpricot(stream).at('a.link').attributes['href'] }
        end
      end

      def keepvid(uri)
        "http://keepvid.com/?url=#{uri}"
      end

      def parse_uri(uri)
        URI.parse(uri)
      rescue URI::InvalidURIError => error
        puts error.message
      end
    end
  end
end
