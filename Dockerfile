FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        zip \
        unzip \
        git \
        wget \
    && docker-php-ext-install -j$(nproc) gd sockets bcmath \
    && pecl install ds pcov \
    && docker-php-ext-enable ds \
    && wget https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 \
    && mv test-reporter-latest-linux-amd64 /usr/bin/cc-test-reporter  \
    && chmod +x /usr/bin/cc-test-reporter

ARG WITH_XDEBUG=false

RUN if [ $WITH_XDEBUG = "true" ] ; then \
        pecl install channel://pecl.php.net/xdebug-3.0.1; \
        docker-php-ext-enable xdebug; \
fi;
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /opt/project



