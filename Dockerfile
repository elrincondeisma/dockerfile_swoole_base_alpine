FROM php:8.0.11-fpm-alpine
RUN apk --no-cache upgrade && \
    apk --no-cache add bash git sudo openssh  libxml2-dev oniguruma-dev autoconf gcc g++ make npm freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev 





# PHP: Install php extensions
RUN pecl channel-update pecl.php.net
RUN pecl install pcov ssh2 swoole
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install mbstring xml iconv pcntl gd zip sockets pdo  pdo_mysql bcmath soap
RUN docker-php-ext-enable mbstring xml gd iconv zip pcov pcntl sockets bcmath pdo  pdo_mysql soap swoole


RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer​ | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
