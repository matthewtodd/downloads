module Downloads
  module Servers
    class Local < Base
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def rsync_path
        "#{@directory}/"
      end

      def run(command)
        `sh -c "cd #{@directory}; #{command}"`
      end
    end
  end
end
