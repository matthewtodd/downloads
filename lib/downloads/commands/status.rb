module Downloads
  module Commands
    class Status < Base
      def run
        longest_filename = remote.files.map { |file| file[:name] }.max { |a, b| a.length <=> b.length }
        remote.files.each do |file|
          puts "%3d%%\t%-#{longest_filename.length}s\t%5s" % [status(file), file[:name], human_readable(file[:size])]
        end
      end

      private

      def human_readable(bytes)
        case bytes
        when (0...1024)
          "#{bytes}B"
        when (1024...1024**2)
          "#{bytes/1024}K"
        when (1024**2...1024**3)
          "#{bytes/1024**2}M"
        else
          "#{bytes/1024**3}G"
        end
      end

      def percent(numerator, denominator)
        (numerator.to_f * 100 / denominator).to_i
      end

      def status(remote_file)
        local_file = local.exists?(remote_file[:name]) || { :name => remote_file[:name], :size => 0 }
        percent(local_file[:size], remote_file[:size])
      end
    end
  end
end
