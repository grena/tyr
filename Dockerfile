FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
        git \
        libzip-dev \
        libxml2-dev \
        zip

RUN usermod --uid 1000 www-data && groupmod --gid 1000 www-data

RUN mkdir -p /var/www/.composer && chown www-data:www-data /var/www/.composer
RUN mkdir -p /var/www/.cache && chown www-data:www-data /var/www/.cache

RUN docker-php-ext-install zip
