FROM php:8.2-fpm

RUN apt update  \
    && apt upgrade -y mc git curl nodejs npm \
    && docker-php-ext-install pdo_mysql bcmath

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./ini/php.ini /usr/local/etc/php/conf.d/php.ini

WORKDIR /var/www/laravel

ARG GID=1000
ARG UID=1000
ARG UNAME=app-user

RUN groupadd -g ${GID} -o ${UNAME} \
    && useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
USER ${UNAME}
