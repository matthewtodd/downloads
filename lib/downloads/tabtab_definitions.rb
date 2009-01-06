TabTab::Definition.register('downloads') do |c|
  def clipboard_contents
    [`pbpaste`.strip]
  end

  def commands
    require File.join(File.dirname(__FILE__), '..', 'downloads') unless Object.const_defined?(:Downloads)
    Downloads::Commands.names
  end

  def remote_files
    require File.join(File.dirname(__FILE__), '..', 'downloads') unless Object.const_defined?(:Downloads)
    Downloads::Commands.configuration.remote_server.filenames
  end

  # FIXME waiting for tabtab to support completion for multiple filenames
  c.command(:add) do |add|
    add.default { clipboard_contents.grep(/^http:/) }
  end

  c.command(:config) do |config|
    config.command(:remote_host)      { }
    config.command(:remote_directory) { }
    config.command(:local_directory)  { }
  end

  c.command(:help) do |help|
    help.default { commands }
  end

  c.command(:ls) do |ls|
  end

  c.command(:mv) do |mv|
    mv.default { remote_files }
  end

  # FIXME waiting for tabtab to support completion for multiple filenames
  c.command(:rm) do |rm|
    rm.default { remote_files }
  end

  c.command(:quit) do |shell|
  end

  c.command(:shell) do |shell|
  end

  c.command(:status) do |status|
  end

  c.command(:sync) do |sync|
    sync.command :kill
  end
end
