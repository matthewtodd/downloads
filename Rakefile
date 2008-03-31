require 'rubygems'
require 'rake/gemreleasetask'

spec = Gem::Specification.new do |spec| 
  spec.name             = 'downloads'
  spec.version          = '0.2.1'
  spec.summary          = 'Downloads uses ssh, rsync and tmail to reliably get big files into Tanzania.'
  spec.files            = FileList['README', 'TODO', 'bin/*', 'lib/**/*.rb'].to_a
  spec.executables      = ['check_downloads', 'cleanup_downloads', 'download', 'extract_attachments', 'pending_downloads', 'restart_downloading', 'stop_downloading']
  spec.author           = 'Matthew Todd'
  spec.email            = 'matthew.todd@gmail.com'
  spec.homepage         = 'http://www.matthewtodd.org'
  
  spec.add_dependency     'tmail', '>= 1.2.2'
  
  spec.requirements    << 'ssh'
  spec.requirements    << 'openssl'
  spec.requirements    << 'diff'
  spec.requirements    << 'rsync'
  spec.requirements    << 'growlnotify'
end

Rake::GemReleaseTask.new(spec) do |task|
  task.remote_gem_host  = 'woodward'
  task.remote_gem_dir   = '/users/home/matthew/domains/gems.matthewtodd.org/web/public'
end
