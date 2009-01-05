module Downloads
  module Commands
    class Mv < Base
      attr_accessor :source, :target

      def self.usage
        "#{super} SOURCE TARGET"
      end

      def configure(argv)
        self.source = shift_argument(argv)
        self.target = shift_argument(argv)
      end

      def run
        remote.run("mv '#{source}' '#{target}'")
        local.run("mv '#{source}' '#{target}'") if local.exists?(source)
      end

      def valid?
        source && target
      end
    end
  end
end
