#!/bin/bash

chown -R www-data:www-data /var/www/*;
chmod -R 755 /var/www/*;
mkdir -p /run/php/;
touch /run/php/php7.4-fpm.pid;

if [ ! -f /var/www/html/wp-config.php ]; then
    mkdir -p /var/www/html;
    cd /var/www/html;

    wp core download --allow-root;

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOSTNAME;

    echo "Success: WordPress installation has started. Wait until the installation is completed."

    wp core install --allow-root \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_LOGIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL;

    wp user create --allow-root \
        $WP_USER_LOGIN $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD;
fi

echo "Success: You can visit $WP_URL in your browser."

exec "$@"