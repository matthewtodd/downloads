# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{downloads}
  s.version = "0.6.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Todd"]
  s.date = %q{2009-01-06}
  s.default_executable = %q{downloads}
  s.email = %q{matthew.todd@gmail.com}
  s.executables = ["downloads"]
  s.extra_rdoc_files = ["README.rdoc", "TODO.rdoc", "bin/downloads"]
  s.files = ["README.rdoc", "TODO.rdoc", "bin/downloads", "lib/downloads/commands/add.rb", "lib/downloads/commands/attachments.rb", "lib/downloads/commands/config.rb", "lib/downloads/commands/help.rb", "lib/downloads/commands/ls.rb", "lib/downloads/commands/mv.rb", "lib/downloads/commands/quit.rb", "lib/downloads/commands/rm.rb", "lib/downloads/commands/shell.rb", "lib/downloads/commands/status.rb", "lib/downloads/commands/sync.rb", "lib/downloads/commands.rb", "lib/downloads/configuration.rb", "lib/downloads/servers/local.rb", "lib/downloads/servers/remote.rb", "lib/downloads/servers.rb", "lib/downloads/tabtab_definitions.rb", "lib/downloads.rb", "resources/applescripts", "resources/applescripts/Add Downloads.app", "resources/applescripts/folderaction_download_webloc.scpt", "resources/applescripts/netnewswire_download_enclosure.scpt"]
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.rdoc", "--title", "downloads-0.6.6", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.requirements = ["rsync"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Downloads uses net-ssh, rsync and tmail to reliably get big files into Tanzania.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ssh>, [">= 2.0.3"])
      s.add_runtime_dependency(%q<tabtab>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<tmail>, [">= 1.2.2"])
    else
      s.add_dependency(%q<net-ssh>, [">= 2.0.3"])
      s.add_dependency(%q<tabtab>, [">= 0.9.1"])
      s.add_dependency(%q<tmail>, [">= 1.2.2"])
    end
  else
    s.add_dependency(%q<net-ssh>, [">= 2.0.3"])
    s.add_dependency(%q<tabtab>, [">= 0.9.1"])
    s.add_dependency(%q<tmail>, [">= 1.2.2"])
  end
end
