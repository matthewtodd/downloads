module Downloads
  module Commands
    class Config < Base
      def run
        puts configuration.to_yaml
      end
    end
  end
end
