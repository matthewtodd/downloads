require 'yaml'

module Downloads
  module Configuration
    CONFIG_FILE       = File.join(ENV['HOME'], '.downloads', 'config')
    PID_FILE          = File.join(ENV['HOME'], '.downloads', 'pid')
    REMOTE_CACHE_FILE = File.join(ENV['HOME'], '.downloads', 'remote_cache')

    def self.[](key)
      @@configuration ||= YAML.load_file(CONFIG_FILE)
      @@configuration[key]
    end

    def self.pid_file
      PID_FILE
    end

    def self.remote_cache_file
      REMOTE_CACHE_FILE
    end
  end
end