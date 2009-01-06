require 'pathname'
require 'yaml'

module Downloads
  class Configuration
    DIRECTORY = Pathname.new(File.join(ENV['HOME'], '.downloads'))
    DEFAULTS = { 'remote_host' => 'downloads', 'remote_directory' => 'downloads', 'local_directory' => File.join(ENV['HOME'], 'Desktop') }.freeze

    def initialize
      DIRECTORY.mkdir unless DIRECTORY.directory?

      @values = DEFAULTS.dup
      @values.merge!(YAML.load_file(path('config'))) if path('config').file?
    end

    def [](key)
      @values[key.to_s]
    end

    def []=(key, value)
      @values[key.to_s] = value
      File.open(path('config'), 'w') { |file| file.write(to_yaml) }
    end

    def local_server
      @local ||= Servers::Local.new(@values['local_directory'])
    end

    def remote_server
      @remote ||= Servers::Remote.new(@values['remote_host'], @values['remote_directory'], path('remote_cache'))
    end

    def pid_file
      path('pid')
    end

    def to_yaml
      @values.to_yaml
    end

    private

    def path(path)
      DIRECTORY + path
    end
  end
end