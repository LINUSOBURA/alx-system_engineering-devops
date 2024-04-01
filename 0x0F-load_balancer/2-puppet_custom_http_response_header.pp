# Define a Puppet class for configuring Nginx with a custom header
class nginx_custom_header {

  # Install Nginx package
  package { 'nginx':
    ensure  => installed,
    require => Apt::Update,
  }

  # Allow Nginx HTTP through UFW firewall
  exec { 'Allow Nginx HTTP':
    command => 'ufw allow "Nginx HTTP"',
    unless  => 'ufw status | grep "Nginx HTTP"',
    require => Package['nginx'],
  }

  # Define index.html and 404.html files
  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    require => Package['nginx'],
  }

  file { '/var/www/html/404.html':
    ensure  => file,
    content => "Ceci n'est pas une page",
    require => Package['nginx'],
  }

  # Configure Nginx
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
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
  }

  # Restart Nginx service
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/sites-available/default'],
  }
}

# Apply the nginx_custom_header class
include nginx_custom_header
