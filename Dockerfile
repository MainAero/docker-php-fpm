FROM php:7.2-fpm-alpine

WORKDIR /app

RUN apk update && \
    apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev curl-dev libedit-dev libxml2-dev icu-dev gettext-dev libsodium-dev icu-libs libsodium libgd gd-dev libwebp zlib libxpm libwebp-dev zlib-dev libxpm-dev libjpeg jpeg-dev
RUN NPROC=$(getconf _NPROCESSORS_ONLN) && \
    docker-php-ext-install -j${NPROC} iconv curl bcmath json mbstring pdo_mysql opcache readline xml intl gettext opcache exif calendar mysqli sodium
RUN NPROC=$(getconf _NPROCESSORS_ONLN) && \
    docker-php-ext-configure gd \
     --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-install -j${NPROC} gd 
RUN apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev curl-dev libedit-dev libxml2-dev icu-dev libsodium-dev gd-dev libwebp-dev zlib-dev libxpm-dev jpeg-dev
COPY php.ini /usr/local/etc/php/