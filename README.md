# Docker container on CentOS 6.6 with php.5.3 and php-fpm

How to use?
Just look at docker-compose.yml

You must use the volumes (volumes in docker-compose.yml or -v on native docker run at command line) if you want to use a unix socket for php-fpm. In another case, you must use the port - may be with port forwarding (just test it)

You can find all environment variables in docker-compose.yml or Dockerfile (it as defaults here)
