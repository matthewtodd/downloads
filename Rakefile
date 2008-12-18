require 'rubygems'
require 'rake/clean'
require 'rake/rdoctask'

spec = Gem::Specification.new do |spec|
  spec.name             = 'downloads'
  spec.version          = '0.2.99'
  spec.summary          = 'Downloads uses ssh, rsync and tmail to reliably get big files into Tanzania.'
  spec.files            = FileList['*.rdoc', 'bin/*', 'lib/**/*.rb'].to_a
  spec.executables      = ['downloads']
  spec.author           = 'Matthew Todd'
  spec.email            = 'matthew.todd@gmail.com'
  spec.homepage         = 'http://matthewtodd.org'

  spec.add_dependency     'tmail', '>= 1.2.2'

  spec.requirements    << 'ssh'
  spec.requirements    << 'openssl'
  spec.requirements    << 'diff'
  spec.requirements    << 'rsync'
end

desc 'Generate a gemspec file'
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

desc 'Generate documentation for the has_digest plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'docs'
  rdoc.title    = 'Downloads'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('TODO.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

