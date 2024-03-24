# Client configuration file

#ssh_config settings for ssh

file { '/etc/ssh/ssh_config':
  ensure  =>  present,
  content =>  "\

Host *
  IdentityFile ~/.ssh/school
  PasswordAuthentication no
",

}
