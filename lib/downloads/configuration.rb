require 'yaml'

module Downloads
  module Configuration
    CONFIG_FILE = File.join(ENV['HOME'], '.downloads', 'config')

    def self.[](key)
      @@configuration ||= YAML.load_file(CONFIG_FILE)
      @@configuration[key]
    end
  end
end