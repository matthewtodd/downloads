require 'tempfile'
require 'rubygems'
require 'tmail'

class Downloads
  attr_reader :remote_host
  attr_reader :remote_directory
  attr_reader :local_directory
  
  def initialize
    @remote_host      = 'matthewtodd.org'
    @remote_directory = '/users/home/matthew/downloads'
    @local_directory  = '/Users/mtodd/Desktop'
  end
  
  def check
    Tempfile.open('remote_md5s') do |remote|
      remote.write `ssh #{remote_host} 'cd #{remote_directory}; openssl md5 *'`
      remote.rewind
      
      Tempfile.open('local_md5s') do |local|
        local.write `cd #{local_directory}; openssl md5 *`
        local.rewind
        
        incomplete_files = `diff #{remote.path} #{local.path}`.scan(/^< MD5\((.+)\)= .*$/).flatten

        if incomplete_files.any?
          notify "These aren't finished downloading", incomplete_files.join("\n")
        else
          notify 'Downloads complete'
        end
      end
    end
  end
  
  def clean
    exec 'ssh', remote_host, "cd #{remote_directory}; rm *"
  end
  
  def extract_attachments(stream)
    TMail::Mail.parse(stream.read).attachments.each do |attachment|
      filename = File.join(remote_directory, attachment.original_filename)
      File.open(filename, 'wb') { |file| file.write(attachment.read) }
      File.chmod(0644, filename)
    end
  end
  
  def fetch(url, *options)
    exec 'ssh', remote_host, "cd #{remote_directory}; wget '#{url}' #{options.join(' ')}"
  end
    
  def pending
    exec 'ssh', remote_host, "ls -lh #{remote_directory} | cut -c 32-38,51- | tail +2"
  end
  
  def restart
    `killall rsync`
    exec 'rsync', '--recursive', '--partial', '--progress', "#{remote_host}:#{remote_directory}/", "#{local_directory}/"
  end
  
  def stop
    `killall rsync`
  end
  
  private
  
  def notify(title, message='')
    `growlnotify --sticky --title "#{title}" --message "#{message}"`
  end
end