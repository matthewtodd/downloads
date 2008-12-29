require 'rubygems'
require 'tmail'

module Downloads
  module Commands
    class Attachments < Base
      attr_accessor :stream

      def configure(argv)
        self.stream = ARGF
      end

      def run
        TMail::Mail.parse(stream.read).attachments.each do |attachment|
          filename = File.join(local.directory, attachment.original_filename)
          File.open(filename, 'wb') { |file| file.write(attachment.read) }
          File.chmod(0644, filename)
        end
      end
    end
  end
end
