require 'yaml'

module Downloads
  module Servers
    CONFIG_FILE = File.join(ENV['HOME'], '.downloads')

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
        @files ||= YAML.load(run(%{ruby -ryaml -e \\"puts Dir.glob('*').map { |name| { :name => name, :size => File.size(name) } }.to_yaml\\"}))
      end
    end

    class Local < Base
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

    class Fake < Base
      def run(command)
        puts command
      end
    end
  end
end