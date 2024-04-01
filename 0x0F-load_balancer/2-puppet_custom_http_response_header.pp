# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  content => "
server {
	listen 80;
	listen [::]:80 default_server;
	root /var/www/html;
	index index.html;
  add_header X-Served-By $hostname;
	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}
	error_page 404 /404.html;
	location /404.html {
		root /var/www/html;
		internal;
	}
}",
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
