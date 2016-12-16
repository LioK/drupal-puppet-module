class drupal::conf {
    # You can change the values of these variables
    # according to your preferences
    # ! DO NOT forget to add MySQL root pwd after installation
    $db_name = 'drupaldb'
    $db_user = 'drupal'
    $db_user_password = 'drupal'
    $db_host = 'localhost'

    $site_name = 'altoros'
    $drupal_user_account = 'altoros'
    $drupal_user_password = 'altoros'

    # Don't change the following variables

    # This will evaluate to drupal@localhost
    $db_user_host = "${db_user}@${db_host}"

    # This will evaluate to wp@localhost/wordpress.*
    $db_user_host_db = "${db_user}@${db_host}/${db_name}.*"
}
