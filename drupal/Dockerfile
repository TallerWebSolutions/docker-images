FROM nginx:latest
MAINTAINER Taller Development Team <dev@taller.net.br>

# Configure Debian environment.
# -----------------------------

ENV DEBIAN_FRONTEND noninteractive


# Install dependencies.
# ---------------------

RUN apt-get update -y               \
    && apt-get install -y           \
    php5-fpm                        \
    php5-curl                       \
    php5-gd                         \
    php5-geoip                      \
    php5-imagick                    \
    php5-imap                       \
    php5-json                       \
    php5-ldap                       \
    php5-mcrypt                     \
    php5-sqlite                     \
    php5-xdebug                     \
    php5-xmlrpc                     \
    php-apc                         \
    php5-mysqlnd                    \
    php5-memcached                  \
    php5-memcache                   \
    sudo                            \
		htop                            \
		curl                            \
		git                             \
		libpng12-dev                    \
		libjpeg-dev                     \
		libpq-dev                       \
    vim                             \
    imagemagick                     \
    mysql-client                    \
    bash-completion                 \
    libfontconfig1                  \
    bzip2                           \
    build-essential                 \
    python-software-properties      \
    locales                         \
    wget                            \
    openconnect                     \
    netcat                          \
    tig                             \
    ca-certificates                 \
    xz-utils                        \
    libfontconfig1                  \
    ssh                             \
    nano                            \
    rsync                           \
    --no-install-recommends         \
    && apt-get clean                \
    && rm -rf /var/lib/apt/lists/*  \
    && rm -rf /tmp/*                \
    && rm -rf /var/tmp/*


# Configure Composer related environment.
# ---------------------------------------

### INSTALL COMPOSER
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1


# Install Composer.
# -----------------

RUN curl -sS https://getcomposer.org/installer | php    \
    && mv composer.phar /usr/local/bin/composer         \
    && composer self-update                             \
    && composer global require "hirak/prestissimo:^0.3"
