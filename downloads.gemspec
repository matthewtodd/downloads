# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{downloads}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Todd"]
  s.date = %q{2008-12-31}
  s.default_executable = %q{downloads}
  s.email = %q{matthew.todd@gmail.com}
  s.executables = ["downloads"]
  s.extra_rdoc_files = ["README.rdoc", "TODO.rdoc", "bin/downloads"]
  s.files = ["README.rdoc", "TODO.rdoc", "bin/downloads", "lib/downloads/commands/add.rb", "lib/downloads/commands/attachments.rb", "lib/downloads/commands/help.rb", "lib/downloads/commands/ls.rb", "lib/downloads/commands/mv.rb", "lib/downloads/commands/rm.rb", "lib/downloads/commands/status.rb", "lib/downloads/commands/sync.rb", "lib/downloads/commands.rb", "lib/downloads/servers/fake.rb", "lib/downloads/servers/local.rb", "lib/downloads/servers/remote.rb", "lib/downloads/servers.rb", "lib/downloads/tabtab_definitions.rb", "lib/downloads.rb"]
  s.has_rdoc = true
  s.post_install_message = %q{== Bash Completion

Downloads supplies pre-packaged definitions for Dr. Nic's
tabtab[http://github.com/drnic/tabtab] gem. After installing, simply run

  install_tabtab

to update your configuration, which you should only need to do once.
}
  s.rdoc_options = ["--main", "README.rdoc", "--title", "downloads-0.5.0", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.requirements = ["rsync"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Downloads uses net-ssh, rsync and tmail to reliably get big files into Tanzania.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tmail>, [">= 1.2.2"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 2.0.3"])
    else
      s.add_dependency(%q<tmail>, [">= 1.2.2"])
      s.add_dependency(%q<net-ssh>, [">= 2.0.3"])
    end
  else
    s.add_dependency(%q<tmail>, [">= 1.2.2"])
    s.add_dependency(%q<net-ssh>, [">= 2.0.3"])
  end
end
