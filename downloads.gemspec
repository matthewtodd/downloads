# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{downloads}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Todd"]
  s.date = %q{2008-12-29}
  s.default_executable = %q{downloads}
  s.email = %q{matthew.todd@gmail.com}
  s.executables = ["downloads"]
  s.extra_rdoc_files = ["README.rdoc", "TODO.rdoc", "bin/downloads"]
  s.files = ["README.rdoc", "TODO.rdoc", "bin/downloads", "lib/downloads/commands/add.rb", "lib/downloads/commands/attachments.rb", "lib/downloads/commands/complete.rb", "lib/downloads/commands/help.rb", "lib/downloads/commands/mv.rb", "lib/downloads/commands/rm.rb", "lib/downloads/commands/status.rb", "lib/downloads/commands/sync.rb", "lib/downloads/commands.rb", "lib/downloads/servers/fake.rb", "lib/downloads/servers/local.rb", "lib/downloads/servers/remote.rb", "lib/downloads/servers.rb", "lib/downloads.rb"]
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.rdoc", "--title", "downloads-0.4.0", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.requirements = ["ssh", "rsync"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Downloads uses ssh, rsync and tmail to reliably get big files into Tanzania.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tmail>, [">= 1.2.2"])
    else
      s.add_dependency(%q<tmail>, [">= 1.2.2"])
    end
  else
    s.add_dependency(%q<tmail>, [">= 1.2.2"])
  end
end
