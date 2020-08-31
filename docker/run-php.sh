#!/bin/bash

if [ ! -f /mw/LocalSettings.php ]; then
    touch /mw/LocalSettings.php
    php /var/www/html/maintenance/install.php --dbname=$wgDBname --dbserver=$wgDBserver --installdbuser=root --installdbpass=$wgDBpassword --dbuser=$wgDBuser --dbpass=$wgUserDBpassword --server='' --scriptpath='' --lang=en --pass=aaaaa 'Wiki Name' 'Admin'
    cp /var/www/html/LocalSettings.php /mw/LocalSettings.php
fi

# loop here to check the amount of the size
cp /mw/LocalSettings.php /var/www/html/LocalSettings.php

exec /usr/sbin/php-fpm --nodaemonize