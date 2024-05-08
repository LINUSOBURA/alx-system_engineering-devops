# fix wp-settings.php

exec{'fix-wordpress_settings_file' :
      command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
      path => '/usr/local/bin/:/bin/'
	
}
