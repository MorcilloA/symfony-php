ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-apache

RUN a2enmod rewrite

RUN apt update \
    && apt-get install -y libzip-dev git wget --no-install-recommends \
    && apt-get clean

RUN docker-php-ext-install pdo mysqli pdo_mysql zip;

RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
RUN apt install -y symfony-cli

RUN wget https://getcomposer.org/download/2.0.9/composer.phar \
    && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

COPY . /var/www/app
COPY ./apache/default-apache.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/app

CMD ["apache2-foreground"]
