require 'rubygems'
require 'rake/clean'
require 'rake/rdoctask'
require 'rake/testtask'

task :default => :test

spec = Gem::Specification.new do |spec|
  spec.name             = 'downloads'
  spec.version          = '0.4.0'
  spec.summary          = 'Downloads uses ssh, rsync and tmail to reliably get big files into Tanzania.'
  spec.files            = FileList['*.rdoc', 'bin/*', 'lib/**/*.rb'].to_a
  spec.has_rdoc         = true
  spec.rdoc_options     = %W[--main README.rdoc --title #{spec.name}-#{spec.version} --inline-source --line-numbers]
  spec.extra_rdoc_files = FileList['*.rdoc', 'bin/*'].to_a
  spec.executables      = ['downloads']
  spec.author           = 'Matthew Todd'
  spec.email            = 'matthew.todd@gmail.com'

  spec.add_dependency     'tmail', '>= 1.2.2'

  spec.requirements    << 'ssh'
  spec.requirements    << 'rsync'
end

desc 'Generate a gemspec file'
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

desc 'Generate documentation for the downloads gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'docs'
  rdoc.options    = spec.rdoc_options
  rdoc.rdoc_files = spec.files
end

desc 'Test the downloads gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
