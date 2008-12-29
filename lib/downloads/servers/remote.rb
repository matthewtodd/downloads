module Downloads
  module Servers
    class Remote < Base
      def initialize(host, directory)
        @host, @directory = host, directory
      end

      def rsync_path
        "#{@host}:#{@directory}/"
      end

      def run(command)
        `ssh #{@host} "cd #{@directory}; #{command}"`
      end
    end
  end
end
