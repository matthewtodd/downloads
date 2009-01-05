module Downloads
  module Commands
    class Sync < Base
      PID_FILE = File.join(ENV['HOME'], '.downloads', 'pid')

      attr_accessor :kill

      def self.usage
        "#{super} [kill]"
      end

      def configure(argv)
        self.kill = (shift_argument(argv) == 'kill')
      end

      def run
        if File.exists?(PID_FILE)
          `kill #{File.read(PID_FILE)}`
          File.delete(PID_FILE)
        end

        unless kill
          pid = fork { exec("rsync --recursive --progress --partial #{remote.rsync_path} #{local.rsync_path}") }
          File.open(PID_FILE, 'w') { |file| file.write(pid) }
          Process.wait
        end
      end
    end
  end
end
