FROM php:7.3-apache
RUN apt-get update \
    && apt-get install -y zip libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-install mysqli gd
# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php composer-setup.php --install-dir=/bin --filename=composer &&\
    a2enmod rewrite
# Slim framework
COPY misc/.htaccess /var/www/html