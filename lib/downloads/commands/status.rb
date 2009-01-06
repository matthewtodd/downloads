module Downloads
  module Commands
    class Status < Base
      def run
        longest_filename = remote.filenames.max { |a, b| a.length <=> b.length }
        remote.files.each do |file|
          puts "%-#{longest_filename.length}s\t%3s%%\t%5s" % [file[:name], status(file), human_readable(file[:size])]
        end
      end

      private

      def status(remote_file)
        local_file = local.files.detect(:size => 0) { |file| file[:name] == remote_file[:name] }
        percent(local_file[:size], remote_file[:size])
      end

      def percent(numerator, denominator)
        if denominator.zero? # oddly enough, this is happening for a .webloc file on my Desktop right now
          '-'
        else
          (numerator.to_f * 100 / denominator).to_i
        end
      end

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
    end
  end
end
