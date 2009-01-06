module Downloads
  module Servers
    class Base
      def exists?(filename)
        filenames.include?(filename)
      end

      def files
        raise NotImplementedError
      end

      def filenames
        files.map { |file| file[:name] }
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

require 'downloads/servers/local'
require 'downloads/servers/remote'
