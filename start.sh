#!/bin/bash

PHP_FPM_CONFIG_FILE=/etc/php-fpm.d/www.conf
PHP_INI_FILE=/etc/php.ini

# Use UNIX socket or port
if [[ ${PHP_FPM_USE_SOCKET} -eq 1 ]]; then
    mkdir -p `echo ${PHP_FPM_SOCKET_PATH} | egrep -o '^\/.+\/'` 
    sed -i "s/^listen = 127.0.0.1:9000$/listen = ${PHP_FPM_SOCKET_PATH//\//\/}/" ${PHP_FPM_CONFIG_FILE}
else
    sed -i "s/^listen = 127.0.0.1:9000$/listen = 127.0.0.1:${PHP_FPM_PORT}/" ${PHP_FPM_CONFIG_FILE}
fi

# Change php-fpm config
sed -i "s/^pm\.max_children = 50$/pm.max_children = ${PHP_FPM_PM_MAX_CHILDREN}/" ${PHP_FPM_CONFIG_FILE}
sed -i "s/^;pm\.max_requests = 500$/pm.max_requests = ${PHP_FPM_PM_MAX_REQESTS}/" ${PHP_FPM_CONFIG_FILE}
sed -i "s/^pm\.start_servers = 5$/pm.start_servers = ${PHP_FPM_PM_START_SERVERS}/" ${PHP_FPM_CONFIG_FILE}
sed -i "s/^pm\.min_spare_servers = 5$/pm.min_spare_servers = ${PHP_FPM_PM_MIN_SPARE_SERVERS}/" ${PHP_FPM_CONFIG_FILE}
sed -i "s/^pm\.max_spare_servers = 35$/pm.max_spare_servers = ${PHP_FPM_PM_MAX_SPARE_SERVERS}/" ${PHP_FPM_CONFIG_FILE}
sed -i "s/^;request_terminate_timeout = 0$/request_terminate_timeout = ${PHP_FPM_REQUEST_TERMINATE_TIMEOUT}/" ${PHP_FPM_CONFIG_FILE}

# Change php.ini
sed -i "s/^;cgi\.fix_pathinfo=1/cgi.fix_pathinfo=0/" ${PHP_INI_FILE}
sed -i "s/register_globals = Off/register_globals = ${PHP_INI_REGISTER_GLOBALS}/" ${PHP_INI_FILE}
sed -i "s/post_max_size = 8M/post_max_size = ${PHP_INI_POST_MAX_SIZE}/" ${PHP_INI_FILE}
sed -i "s/max_input_time = 60/max_input_time = ${PHP_INI_MAX_INPUT_TIME}/" ${PHP_INI_FILE}
sed -i "s/max_execution_time = 30/max_execution_time = ${PHP_INI_MAX_EXECUTION_TIME}/" ${PHP_INI_FILE}
sed -i "s/;date.timezone =/date.timezone = ${PHP_INI_DATE_TIMEZONE//\//\/}/" ${PHP_INI_FILE}
sed -i "s/^upload_max_filesize = 2M$/upload_max_filesize = ${PHP_INI_UPLOAD_MAX_FILESIZE}/" ${PHP_INI_FILE}

# Start php-fpm
/usr/sbin/php-fpm -y ${PHP_FPM_CONFIG_FILE} -c ${PHP_INI_FILE} -F 
