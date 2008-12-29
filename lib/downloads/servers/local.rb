module Downloads
  module Servers
    class Local < Base
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def files
        Dir.chdir(directory) do
          Dir.glob('*').map { |name| { :name => name, :size => File.size(name) } }
        end
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
