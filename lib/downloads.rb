require 'tempfile'
require 'yaml'
require 'rubygems'
require 'tmail'

class Downloads
  CONFIG_FILE = File.join(ENV['HOME'], '.downloads')
  PID_FILE    = File.join(ENV['HOME'], '.downloads.pid')

  attr_reader :remote_host
  attr_reader :remote_directory
  attr_reader :local_directory

  def initialize
    config = YAML.load_file(CONFIG_FILE)

    @remote_host      = config['remote_host']
    @remote_directory = config['remote_directory']
    @local_directory  = config['local_directory']
  end

  def extract(stream)
    TMail::Mail.parse(stream.read).attachments.each do |attachment|
      filename = File.join(remote_directory, attachment.original_filename)
      File.open(filename, 'wb') { |file| file.write(attachment.read) }
      File.chmod(0644, filename)
    end
  end

  def fetch_start
    fetch_stop
    pid = fork { exec 'rsync', '--recursive', '--partial', '--progress', "#{remote_host}:#{remote_directory}/", "#{local_directory}/" }
    File.open(PID_FILE, 'w') { |file| file.write(pid) }
    Process.wait
  rescue Interrupt
    # we don't need to see the stacktrace
  end

  def fetch_stop
    if File.exists?(PID_FILE)
      `kill #{File.read(PID_FILE)}`
      File.delete(PID_FILE)
    end
  end

  def queue_add(url, *options)
    exec 'ssh', remote_host, "cd #{remote_directory}; wget '#{url}' #{options.join(' ')}"
  end

  def queue_check
    Tempfile.open('remote_md5s') do |remote|
      remote.write `ssh #{remote_host} 'cd #{remote_directory}; openssl md5 *'`
      remote.rewind

      Tempfile.open('local_md5s') do |local|
        local.write `cd #{local_directory}; [ "\`ls\`" ] && openssl md5 *`
        local.rewind
        puts `diff #{remote.path} #{local.path}`.scan(/^< MD5\((.+)\)= .*$/).flatten
      end
    end
  end

  def queue_clean
    exec 'ssh', remote_host, "cd #{remote_directory}; rm *"
  end

  def queue_list
    exec 'ssh', remote_host, "ls -lh #{remote_directory}"
  end
end