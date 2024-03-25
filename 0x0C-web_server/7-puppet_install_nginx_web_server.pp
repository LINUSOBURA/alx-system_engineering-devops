# installing and configuring ngix with puppet


# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable the default site
file { '/etc/nginx/sites-enabled/default':
  ensure  => link,
  target  => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

# Define Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  hasrestart => true,
}

# Template for Nginx default configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Define the template for Nginx default configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Define a custom template for Nginx configuration
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => template('nginx/nginx.conf.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Redirect /redirect_me to the specified URL
nginx::resource::vhost { 'redirect_me':
  ensure  => present,
  www_root => '/var/www/html',
  rewrite_to_https => true,
  rewrite_to_https_code => 301,
  rewrite_rules => [
    { 'from' => '^/redirect_me$', 'to' => 'https://www.youtube.com/watch?v=QH2-TGUlwu4' },
  ],
}

# Ensure Nginx is listening on port 80
nginx::resource::vhost { 'default':
  ensure  => present,
  www_root => '/var/www/html',
  listen_port => 80,
  rewrite_rules => [
    { 'from' => '^/$', 'to' => 'https://www.youtube.com/watch?v=QH2-TGUlwu4' },
  ],
}

# Ensure Nginx returns "Hello World!" for root path /
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}
