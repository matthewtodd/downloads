require 'optparse'

module Downloads
  module Commands
    def self.registry
      @@registry ||= {}
    end

    # MAYBE we could use optparse at this top level as well, allowing for (1) overriding host & directory config and (2) faking remote interactions
    def self.lookup(argv)
      klass = registry[argv.shift] || Help
      klass.new(Servers.local, Servers.remote, argv)
    end

    class Base
      def self.command_name
        name.split('::').last.downcase
      end

      def self.inherited(command)
        Commands.registry[command.command_name] = command
      end

      attr_reader :local, :remote, :options

      def initialize(local, remote, argv)
        @local, @remote = local, remote
        @options = OptionParser.new
        @options.banner = banner
        configure(argv)
        @options.parse!(argv)
        help unless valid?
      rescue OptionParser::InvalidOption, URI::InvalidURIError => e
        puts e.message
        help
      end

      def banner
        "Usage: downloads #{self.class.command_name}"
      end

      def configure(argv)
      end

      def help
        puts @options.help
      end

      def run
        raise NotImplementedError
      end

      def valid?
        true
      end

      private

      def shift_argument(argv)
        argv.shift unless argv.first =~ /^-/
      end
    end
  end
end

require 'downloads/commands/add'
require 'downloads/commands/attachments'
require 'downloads/commands/help'
require 'downloads/commands/ls'
require 'downloads/commands/mv'
require 'downloads/commands/quit'
require 'downloads/commands/rm'
require 'downloads/commands/shell'
require 'downloads/commands/status'
require 'downloads/commands/sync'