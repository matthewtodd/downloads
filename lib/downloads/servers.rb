module Downloads
  module Servers
    def self.local
      @@local ||= Local.new(Configuration['local_directory'])
    end

    def self.remote
      @@remote ||= Remote.new(Configuration['remote_host'], Configuration['remote_directory'])
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
