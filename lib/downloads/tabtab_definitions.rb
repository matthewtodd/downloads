TabTab::Definition.register('downloads') do |c|
  def remote_files
    `downloads ls`.split("\n")
  end

  c.command(:add) do |add|
    add.flag :help
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

  # TODO support completion for multiple filenames
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
