# Creating a file in /tmp

file { '/tmp/school':
  content =>  'I Love Puppet'
  mode    =>  '0744',
  owner   =>  www-data,
  group   =>  www-data,
}
