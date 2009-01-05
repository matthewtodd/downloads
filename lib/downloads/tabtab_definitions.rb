TabTab::Definition.register('downloads') do |c|
  def clipboard_contents
    [`pbpaste`.strip]
  end

  def commands
    require File.join(File.dirname(__FILE__), 'commands') unless Object.const_defined?(:Downloads)
    Downloads::Commands.names
  end

  def remote_files
    `downloads ls`.split("\n")
  end

  # FIXME waiting for tabtab to support completion for multiple filenames
  c.command(:add) do |add|
    add.default { clipboard_contents.grep(/^http:/) }
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
