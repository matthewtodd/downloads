require 'net/ssh'

module Downloads
  module Servers
    class Remote < Base
      def initialize(host, directory, cache_path)
        @host       = host
        @directory  = directory
        @cache_path = cache_path
        @connection = nil
        @files      = YAML.load_file(@cache_path) if File.exists?(@cache_path)
      end

      def files
        populate_file_cache unless @files
        @files
      end

      def rsync_path
        "#{@host}:#{@directory}/"
      end

      def run(command)
        result = run_in_directory(command)
        populate_file_cache
        result
      end

      private

      def connection
        initialize_connection unless @connection
        @connection
      end

      def initialize_connection
        @connection = Net::SSH.start(@host, ENV['USER']) # TODO does it make sense to use ENV['USER']?
        at_exit { @connection.close }
      end

      def run_in_directory(command)
        connection.exec!("cd #{@directory}; #{command}")
      end

      def populate_file_cache
        yaml = run_in_directory(%{ruby -ryaml -e "puts Dir.glob('*').sort.map { |name| { :name => name, :size => File.size(name) } }.to_yaml"})
        File.open(@cache_path, 'w') { |file| file.write(yaml) }
        @files = YAML.load(yaml)
      end
    end
  end
end
