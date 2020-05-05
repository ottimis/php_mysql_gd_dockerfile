FROM php:7.3-apache
ENV TZ=Europe/Rome
RUN apt-get update \
    && apt-get install --no-install-recommends -y zip libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure soap --enable-soap \
    && docker-php-ext-install mysqli gd soap \
    && printf '[PHP]\ndate.timezone = "Europe/Rome"\n' > /usr/local/etc/php/conf.d/tzone.ini \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    # && sed 's/^;date\.timezone[[:space:]]=.*$/date.timezone = "Europe\/Rome"/' \
    && a2enmod rewrite
# Slim framework
COPY misc/.htaccess /var/www/html