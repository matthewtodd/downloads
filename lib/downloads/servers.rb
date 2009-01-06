module Downloads
  module Servers
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
