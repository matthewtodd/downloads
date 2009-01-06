module Downloads
  module Commands
    class Config < Base
      attr_accessor :key, :value

      def self.usage
        "#{super} [KEY [VALUE]]"
      end

      def configure(argv)
        self.key   = shift_argument(argv)
        self.value = shift_argument(argv)
      end

      def run
        if value
          configuration[key] = value
        elsif key
          puts configuration[key]
        else
          puts configuration.to_yaml
        end
      end
    end
  end
end
