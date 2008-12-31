require 'net/ssh'

module Downloads
  module Servers
    class Remote < Base
      CACHE = File.join(ENV['HOME'], '.downloads', 'remote_cache')

      def initialize(host, directory)
        @host, @directory, @connection = host, directory, nil
      end

      def files
        update_file_cache unless File.exists?(CACHE)
        YAML.load_file(CACHE)
      end

      def rsync_path
        "#{@host}:#{@directory}/"
      end

      def run(command)
        result = run_in_directory(command)
        update_file_cache
        result
      end

      private

      def connection
        unless @connection
          @connection = Net::SSH.start(@host, ENV['USER'])
          at_exit { @connection.close }
        end

        @connection
      end

      def run_in_directory(command)
        connection.exec!("cd #{@directory}; #{command}")
      end

      def update_file_cache
        yaml = run_in_directory(%{ruby -ryaml -e "puts Dir.glob('*').map { |name| { :name => name, :size => File.size(name) } }.to_yaml"})
        File.open(CACHE, 'w') { |file| file.write(yaml) }
      end
    end
  end
end
