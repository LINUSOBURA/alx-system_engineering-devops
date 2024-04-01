class { 'nginx': }

# Update package list (assuming you have a separate resource for this)
# exec { 'update_apt': ... }

# Install nginx package
package { 'nginx': ensure => installed }

# Define Nginx configuration using template
template { '/etc/nginx/sites-available/default.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => '/path/to/nginx.conf.erb',  # Replace with your template path
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable the default site
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default.conf',  # Updated target
  notify => Service['nginx'],
}

# Ensure Nginx returns "Hello World!" for root path /
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Create 404 page
file { '/var/www/html/404.html':
  ensure  => file,
  content => "Ceci n'est pas une page",
}

# Define Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  hasrestart => true,
}
