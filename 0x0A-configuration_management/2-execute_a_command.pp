# manifest that kills a process named killmenow

exec {'kill_a_process':
  command =>  '/bin/pkill -9 killmenow',
  path    =>  '/usr/local/bin:/usr/bin:/bin',
  onlyif  =>  '/bin/pgrep killmenow'
}
