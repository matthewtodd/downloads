module Downloads #:nodoc:
  module Commands
    def self.configuration
      @@configuration ||= Configuration.new
    end

    def self.registry
      @@registry ||= {}
    end

    def self.names
      registry.keys.sort
    end

    def self.objects
      registry.values.sort_by { |command| command.command_name }
    end

    # MAYBE we could use optparse at this top level as well, allowing for (1) overriding host & directory config and (2) faking remote interactions
    def self.lookup(argv)
      klass = registry[argv.shift] || Help
      klass.new(configuration, argv)
    end

    class Base
      def self.command_name
        name.split('::').last.downcase
      end

      def self.usage
        command_name
      end

      def self.inherited(command)
        Commands.registry[command.command_name] = command
      end

      attr_reader :configuration, :local, :remote, :options

      def initialize(configuration, argv)
        @configuration = configuration
        @local         = configuration.local_server
        @remote        = configuration.remote_server
        configure(argv)
      end

      def configure(argv)
      end

      def usage
        self.class.usage
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
require 'downloads/commands/config'
require 'downloads/commands/help'
require 'downloads/commands/ls'
require 'downloads/commands/mv'
require 'downloads/commands/quit'
require 'downloads/commands/rm'
require 'downloads/commands/shell'
require 'downloads/commands/status'
require 'downloads/commands/sync'
require 'downloads/commands/video'