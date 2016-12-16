node default {
    class { 'drupal':
    }
    Exec {
    path => '/bin, /sbin',
    }
}
