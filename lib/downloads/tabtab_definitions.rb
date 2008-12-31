TabTab::Definition.register('downloads') do |c|
  def clipboard_contents
    [`pbpaste`.strip]
  end

  def remote_files
    `downloads ls`.split("\n")
  end

  c.command(:add) do |add|
    add.flag :help
    add.default { clipboard_contents }
  end

  c.command(:help) do |help|
  end

  c.command(:ls) do |ls|
    ls.flag :help
  end

  c.command(:mv) do |mv|
    mv.flag :help
    mv.default { remote_files }
  end

  # FIXME waiting for tabtab to support completion for multiple filenames
  c.command(:rm) do |rm|
    rm.flag :help
    rm.default { remote_files }
  end

  c.command(:status) do |status|
    status.flag :help
  end

  c.command(:sync) do |sync|
    sync.flag :help
    sync.flag :kill
  end
end
