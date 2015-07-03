FROM centos:6.6

MAINTAINER Dmitry Vapelnik <dvapelnik@gmail.com>

RUN yum install php-fpm php-mysql php-mbstring -y -q 2> /dev/null

ENV PHP_FPM_USE_SOCKET 0
ENV PHP_FPM_PORT 9000
ENV PHP_FPM_SOCKET_PATH /var/php-fpm/run/php-fpm.sock
ENV PHP_FPM_PM_MAX_CHILDREN 50
ENV PHP_FPM_PM_MAX_REQESTS 500
ENV PHP_FPM_PM_START_SERVERS 5
ENV PHP_FPM_PM_MIN_SPARE_SERVERS 5
ENV PHP_FPM_PM_MAX_SPARE_SERVERS 35
ENV PHP_FPM_REQUEST_TERMINATE_TIMEOUT 0

ENV PHP_INI_REGISTER_GLOBALS Off
ENV PHP_INI_POST_MAX_SIZE 8M
ENV PHP_INI_MAX_INPUT_TIME 60
ENV PHP_INI_MAX_EXECUTION_TIME 30
ENV PHP_INI_DATE_TIMEZONE Europe/London

ADD ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
