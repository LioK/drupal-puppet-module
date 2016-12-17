class drupal::site {

    # Install Apache
    package { 'apache2':
        ensure => installed,
    }

    # Install apache2-utils
    package { 'apache2-utils':
        ensure => installed,
    }

    # Install PHP5
    package { 'php5':
        ensure => installed,
    }

    # Install php5-mysql
    package { 'php5-mysql':
        ensure => installed,
    }

    # Install php-pear
    package { 'php-pear':
        ensure => installed,
    }

    # Install php5-gd
    package { 'php5-gd':
        ensure => installed,
    }

    # Install php5-mcrypt
    package { 'php5-mcrypt':
        ensure => installed,
    }

    # Install php5-curl
    package { 'php5-curl':
        ensure => installed,
    }

    # Install mysql-server
    package { 'mysql-server':
        ensure => installed,
    }

    # Install libapache2-mod-auth-mysql
    package { 'libapache2-mod-auth-mysql':
        ensure => installed,
    }

    # Install Drush
    package { 'drush':
        ensure => installed,
    }

    # Copy the apache.conf file to the Drupal VM
    file { '/etc/apache2/apache2.conf':
        content => template("drupal/apache2.conf.erb"),
    }

    # Enable mod_rewrite and restart apache2
    exec { 'a2enmod rewrite':
        command => 'a2enmod rewrite',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    # Enable mod_rewrite and restart apache2
    exec { 'service apache2 restart':
        command => 'service apache2 restart',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    # Copy the my.cnf file to the Drupal VM, restart MySQL
    file { '/etc/mysql/my.cnf':
        ensure => present,
        content => template("drupal/my.cnf.erb"),
    }

    # Restart mysql
    exec { 'service mysql restart':
        command => 'service mysql restart',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    exec { 'mysql -u root -e "USE mysql; CREATE DATABASE drupaldb; CREATE USER drupal@localhost IDENTIFIED BY \"drupal\"; GRANT ALL PRIVILEGES ON drupaldb.* TO drupal@localhost; FLUSH PRIVILEGES;"': 
        command => 'mysql -u root -e "USE mysql; CREATE DATABASE drupaldb; CREATE USER drupal@localhost IDENTIFIED BY \"drupal\"; GRANT ALL PRIVILEGES ON drupaldb.* TO drupal@localhost; FLUSH PRIVILEGES;"',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    exec { 'drush dl drupal --drupal-project-rename=html -y':
        cwd => '/var/www/',
        command => 'drush dl drupal --drupal-project-rename=html -y',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    exec { 'sudo drush site-install standard --db-url=mysql://drupal:drupal@localhost/drupaldb --site-name=altoros --account-name=drupal --account-pass=drupal -y':
        cwd => '/var/www/html/',
        command => 'sudo drush site-install standard --db-url=mysql://drupal:drupal@localhost/drupaldb --site-name=altoros --account-name=drupal --account-pass=drupal -y',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }

    exec { 'chown -R www-data:www-data /var/www/html':
        command => 'chown -R www-data:www-data /var/www/html',
        path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    }
}
