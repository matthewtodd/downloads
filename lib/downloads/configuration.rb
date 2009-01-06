require 'pathname'
require 'yaml'

module Downloads
  class Configuration
    DIRECTORY = Pathname.new(File.join(ENV['HOME'], '.downloads'))
    DEFAULTS = { 'remote_host' => 'downloads', 'remote_directory' => 'downloads', 'local_directory' => File.join(ENV['HOME'], 'Desktop') }.freeze

    attr_reader :local_server, :remote_server

    def initialize
      DIRECTORY.mkdir unless DIRECTORY.directory?

      @values = DEFAULTS.dup
      @values.merge!(YAML.load_file(path('config'))) if path('config').file?

      @local_server  = build_local_server
      @remote_server = build_remote_server
    end

    def [](key)
      @values[key.to_s]
    end

    def []=(key, value)
      @values[key.to_s] = value
      File.open(path('config'), 'w') { |file| file.puts(to_yaml) }

      case key.to_s
      when /^remote/
        File.delete(path('remote_cache')) if path('remote_cache').file?
        @remote_server = build_remote_server
      when /^local/
        @local_server = build_local_server
      end
    end

    def pid_file
      path('pid')
    end

    def to_yaml
      # Marginally nicer than @values.to_yaml, as it avoids the leading '---'
      @values.map { |key, value| "#{key}: #{value}" }.join("\n")
    end

    private

    def build_local_server
      Servers::Local.new(@values['local_directory'])
    end

    def build_remote_server
      Servers::Remote.new(@values['remote_host'], @values['remote_directory'], path('remote_cache'))
    end

    def path(path)
      DIRECTORY + path
    end
  end
end