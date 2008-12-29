require 'yaml'

module Downloads
  module Servers
    CONFIG_FILE = File.join(ENV['HOME'], '.downloads', 'config')

    def self.configuration
      @@configuration ||= YAML.load_file(CONFIG_FILE)
    end

    def self.local
      Local.new(configuration['local_directory'])
    end

    def self.remote
      Remote.new(configuration['remote_host'], configuration['remote_directory'])
    end

    class Base
      def exists?(filename)
        files.detect { |file| file[:name] == filename }
      end

      def files
        raise NotImplementedError
      end

      def rsync_path
        raise NotImplementedError
      end

      def run(command)
        raise NotImplementedError
      end
    end
  end
end

require 'downloads/servers/fake'
require 'downloads/servers/local'
require 'downloads/servers/remote'
