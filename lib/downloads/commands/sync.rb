module Downloads
  module Commands
    class Sync < Base
      attr_accessor :kill

      def self.usage
        "#{super} [kill]"
      end

      def configure(argv)
        self.kill = (shift_argument(argv) == 'kill')
      end

      def run
        if File.exists?(pid_file)
          `kill #{File.read(pid_file)}`
          File.delete(pid_file)
        end

        unless kill
          pid = fork { exec("rsync --recursive --progress --partial #{remote.rsync_path} #{local.rsync_path}") }
          File.open(pid_file, 'w') { |file| file.write(pid) }

          begin
            Process.wait
          rescue Interrupt
            # we don't need to see the stacktrace
            puts # but a blank line is nice
          end
        end
      end

      private

      def pid_file
        configuration.pid_file
      end
    end
  end
end
