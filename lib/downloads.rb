require 'tempfile'
require 'rubygems'
require 'tmail'

class Downloads
  REMOTE_HOST      = 'matthewtodd.org'
  REMOTE_DIRECTORY = '/users/home/matthew/downloads'
  LOCAL_DIRECTORY  = '/Users/mtodd/Desktop'
  FORWARD_TO       = 'matthew.todd@gmail.com'
  
  def check
    Tempfile.open('remote_md5s') do |remote|
      remote.write `ssh #{REMOTE_HOST} 'cd #{REMOTE_DIRECTORY}; openssl md5 *'`
      remote.rewind
      
      Tempfile.open('local_md5s') do |local|
        local.write `cd #{LOCAL_DIRECTORY}; openssl md5 *`
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
    exec 'ssh', REMOTE_HOST, "cd #{REMOTE_DIRECTORY}; rm *"
  end
  
  def extract_attachments(stream)
    TMail::Mail.parse(stream.read).attachments.each do |attachment|
      filename = File.join(REMOTE_DIRECTORY, attachment.original_filename)
      File.open(filename, 'wb') { |file| file.write(attachment.read) }
      File.chmod(0644, filename)
    end
  end
  
  def fetch(url, *options)
    exec 'ssh', REMOTE_HOST, "cd #{REMOTE_DIRECTORY}; wget '#{url}' #{options.join(' ')}"
  end
    
  def pending
    exec 'ssh', REMOTE_HOST, "ls -lh #{REMOTE_DIRECTORY} | cut -c 32-38,51- | tail +2"
  end
  
  def restart
    `killall rsync`
    exec 'rsync', '--recursive', '--partial', '--progress', "#{REMOTE_HOST}:#{REMOTE_DIRECTORY}/", "#{LOCAL_DIRECTORY}/"
  end
  
  def stop
    `killall rsync`
  end
  
  private
  
  def notify(title, message='')
    `growlnotify --sticky --title "#{title}" --message "#{message}"`
  end
end