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

    # Install php5-pear
    package { 'php5-pear':
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
    exec { 'a2enmod':
        command => 'sudo a2enmod rewrite',
    }

    # Enable mod_rewrite and restart apache2
    exec { 'apache2':
        command => 'sudo service apache2 restart',
    }

    # Copy the my.cnf file to the Drupal VM, restart MySQL
    file { '/etc/mysql/my.cnf':
        ensure => present,
        content => template("drupal/my.cnf.erb"),
    }

    # Restart mysql
    exec { 'mysql':
        command => 'sudo service mysql restart',
    }

    exec { 'create drupaldb and user':
        command => 'mysql -u root -e "USE mysql; CREATE DATABASE $db_name; CREATE USER $db_user@$db_host IDENTIFIED BY $db_user_password; GRANT ALL PRIVILEGES ON $db_name.* TO $db_user@$db_host; FLUSH PRIVILEGES;"',
    }

    exec { 'install Drupal with Drush':
        cwd => '/var/www/',
        command => 'sudo drush dl drupal --drupal-project-rename=html -y',
    }

    exec { 'complete Drupal setup with Drush':
        cwd => '/var/www/html/',
        command => 'sudo drush site-install standard --db-url=mysql://$db_user:$db_user_password@localhost/$db_name --site-name=$site_name --account-name=$drupal_user_account --account-pass=$drupal_user_password -y',
    }

    exec { 'change ownership of /var/www/html':
        command => 'sudo chown -R www-data:www-data /var/www/html',
    }
}
