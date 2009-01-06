require 'net/ssh'

module Downloads
  module Servers
    class Remote < Base
      def initialize(host, directory)
        @host, @directory, @connection = host, directory, nil
      end

      # FIXME is it weird to inject host & directory, but look up remote_cache_file?
      def files
        update_file_cache unless File.exists?(Configuration.remote_cache_file)
        YAML.load_file(Configuration.remote_cache_file)
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
        yaml = run_in_directory(%{ruby -ryaml -e "puts Dir.glob('*').sort.map { |name| { :name => name, :size => File.size(name) } }.to_yaml"})
        File.open(Configuration.remote_cache_file, 'w') { |file| file.write(yaml) }
      end
    end
  end
end
