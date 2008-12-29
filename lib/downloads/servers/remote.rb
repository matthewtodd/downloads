module Downloads
  module Servers
    class Remote < Base
      CACHE = File.join(ENV['HOME'], '.downloads', 'remote_cache')

      def initialize(host, directory)
        @host, @directory = host, directory
      end

      def files
        unless File.exists?(CACHE)
          yaml = run(%{ruby -ryaml -e \\"y Dir.glob('*').map { |name| { :name => name, :size => File.size(name) } }\\"})
          File.open(CACHE, 'w') { |file| file.write yaml }
        end

        YAML.load_file(CACHE)
      end

      def rsync_path
        "#{@host}:#{@directory}/"
      end

      # TODO use ssh's control master to speed up re-connecting -- or Net::SSH? Capistrano?
      def run(command)
        File.delete(CACHE) if File.exists?(CACHE)
        `ssh #{@host} "cd #{@directory}; #{command}"`
      end
    end
  end
end
