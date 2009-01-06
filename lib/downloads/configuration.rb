require 'yaml'

module Downloads
  class Configuration
    CONFIG_FILE       = File.join(ENV['HOME'], '.downloads', 'config')
    PID_FILE          = File.join(ENV['HOME'], '.downloads', 'pid')
    REMOTE_CACHE_FILE = File.join(ENV['HOME'], '.downloads', 'remote_cache')

    # TODO discard direct property access
    def [](key)
      @configuration ||= YAML.load_file(CONFIG_FILE)
      @configuration[key]
    end

    def local_server
      @local ||= Servers::Local.new(self['local_directory'])
    end

    def remote_server
      @remote ||= Servers::Remote.new(self['remote_host'], self['remote_directory'], REMOTE_CACHE_FILE)
    end

    def pid_file
      PID_FILE
    end
  end
end