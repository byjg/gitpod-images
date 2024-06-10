FROM gitpod/workspace-full:latest

ENV PHP_VERSION=8.2

RUN sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}

RUN sudo install-packages \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dba \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-igbinary \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-memcached \
    php${PHP_VERSION}-mongodb \
    php${PHP_VERSION}-msgpack \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-phpdbg \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-xdebug \
    php${PHP_VERSION}-xml

