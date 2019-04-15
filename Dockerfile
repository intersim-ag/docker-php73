FROM php:7.3

# Install various dependencies
RUN apt-get update -yqq
RUN apt-get install -yqq \
    curl \
    git \
    gnupg2 \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libldap2-dev \
    libmagickwand-dev \
    libpcre3-dev \
    libpng-dev \
    libssl-dev \
    libtidy-dev \
    libzip-dev \
    pkg-config \
    zlib1g-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install -j$(nproc) \
        calendar \
        curl \
        gd \
        gettext \
        intl \
        ldap \
        opcache \
        tidy \
        zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install node.js & gulp
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get install -y nodejs \
    && npm install -g gulp-cli
