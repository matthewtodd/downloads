module Downloads
  module Servers
    class Fake < Base
      def run(command)
        puts command
      end
    end
  end
end
