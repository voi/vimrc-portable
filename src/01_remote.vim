if has('gui_running') && has('clientserver') && argc() && !&diff && 0
  let servers = filter(split(serverlist(), '\n'), { idx, val -> v:servername !=# val })

  if !empty(servers)
    silent execute '!start gvim'
        \ '--servername' servers[0]
        \ '--remote-tab-silent ' join(map(copy(argv()), { key, val -> fnameescape(val) }), ' ')
    qa!
  endif
endif

