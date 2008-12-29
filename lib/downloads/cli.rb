module Downloads
  class CLI #:nodoc:
    def initialize
      @downloads = Downloads.new
    end

    def complete
      line = ENV['COMP_LINE']
      args = line.split(/\s+/)
      args.shift

      position = args.length + (line.match(/\s$/) ? 1 : 0)
      case position
      when 1
        puts ['fetch', 'queue'].grep(/^#{args[0]}/)
      when 2
        case args[0]
        when 'fetch'
          puts ['--stop']
        when 'queue'
          puts ['http://', '--check', '--clean'].grep(/^#{args[1]}/)
        end
      when 3
        case args[0]
        when 'queue'
          case args[1]
          when /^http/
            require 'uri'
            uri = URI.parse(args[1])
            suggested_filename = uri.path.split(/\//).last
            suggested_filename ||= uri.host.gsub('.', '_')
            puts ["-O #{suggested_filename}"]
          end
        end
      end

    end

    def extract(message)
      @downloads.extract(message)
    end

    def fetch(*args)
      case args.first
      when nil
        @downloads.fetch_start
      when '--stop'
        @downloads.fetch_stop
      else
        usage
      end
    end

    def queue(*args)
      case args.first
      when nil
        @downloads.queue_list
      when '--check'
        @downloads.queue_check
      when '--clean'
        @downloads.queue_clean
      else
        @downloads.queue_add(*args)
      end
    end

    def usage
      puts "Usage:"
      puts "#{$0} extract"
      puts "#{$0} fetch [--stop]"
      puts "#{$0} queue [<url> [-O <filename>]|--check|--clean]"
      exit 1
    end
  end
end