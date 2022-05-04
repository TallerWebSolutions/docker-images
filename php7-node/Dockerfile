FROM ubuntu:20.04
LABEL Taller Development Team <dev@taller.net.br>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/apache2

# Install dependencies.
# ---------------------
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
	  libapache2-mod-php7.4 \
		php7.4 \
		php7.4-common \
		php7.4-mysql \
		php7.4-xml \
		php7.4-xmlrpc \
		php7.4-curl \
		php7.4-gd \
		php7.4-imagick \
		php7.4-cli \
		php7.4-dev \
		php7.4-imap \
		php7.4-mbstring \
		php7.4-opcache \
		php7.4-soap \
		php7.4-zip \
		php7.4-intl \
		php7.4-bcmath \
		php7.4-pgsql \
		php7.4-pspell \
		php7.4-apcu \
		php7.4-memcached \
		php-pear \
		php7.4-redis \
		php7.4-xdebug \
		apache2 \
    bash-completion                 \
    build-essential                 \
    bzip2                           \
    ca-certificates                 \
    curl                            \
    git                             \
    gzip                            \
    htop                            \
    imagemagick                     \
    iputils-ping                    \
    libfontconfig1                  \
    libjpeg-dev                     \
    libpng-dev                      \
    libpq-dev                       \
    locales                         \
    mysql-client                    \
    nano                            \
    netcat                          \
    openconnect                     \
    php7.4-soap                     \
    php7.4-sqlite3                  \
    software-properties-common      \
    rsync                           \
    sudo                            \
    ssh                             \
    tig                             \
    vim                             \
    xz-utils                        \
    wget                            \
    unzip                           \
    --no-install-recommends         \
    && apt-get clean                \
    && rm -rf /tmp/*                \
    && rm -rf /var/tmp/*            \
    && rm -fr /var/lib/apt/lists/*

RUN a2enmod php7.4
RUN a2enmod rewrite
ADD www /var/www/html
ADD apache-conf.conf /etc/apache2/sites-available/site.conf

RUN a2ensite site.conf
RUN a2dissite 000-default.conf

# Configure Composer related environment.
# ---------------------------------------

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1
#
#
# # Install Composer.
# # -----------------
#
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.7.3 \
  && mv composer.phar /usr/local/bin/composer \
  && composer global require "hirak/prestissimo:^0.3"

# Build-time configuration.
# -------------------------
# This is mostly useful to override on CIs.

ARG APP_NAME=taller
ARG GROUP_ID=1000
ARG USER_ID=1000


# Configure environment.
# ----------------------

ENV APP_NAME=${APP_NAME}
ENV GROUP_ID=${GROUP_ID}
ENV GROUP_NAME=${APP_NAME} USER_ID=${USER_ID} USER_NAME=${APP_NAME}


# Create group and user.
# ----------------------

RUN groupadd --gid ${GROUP_ID} ${GROUP_NAME}                                                                          \
  && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers                                                           \
  && useradd -u ${USER_ID} -G users,www-data,sudo -g ${GROUP_NAME} -d /${APP_NAME} --shell /bin/bash -m ${APP_NAME} \
  && echo "secret\nsecret" | passwd ${USER_NAME}


# PHP configs.
# -----------
RUN sudo sh -c "echo '\n\n[xdebug]\nxdebug.remote_autostart = 1\nxdebug.remote_enable = 1\nxdebug.remote_connect_back = 1' \
  >> /etc/php/7.4/apache2/php.ini" \
  && sudo phpdismod xdebug

# Apache2 configs.
# -------------
COPY ./default.conf /etc/apache2/sites-available/

# Import profile files.
# -------------

COPY ./.bashrc /${APP_NAME}/.bashrc
RUN chown ${USER_NAME}:${GROUP_NAME} /${APP_NAME}/.bashrc

# Configure Node related environment.
# -----------------------------------

ENV NVM_DIR /${USER_NAME}/.nvm

# Install Node and Yarn.
# -------------

RUN mkdir /${USER_NAME}/.nvm
COPY ./.nvmrc /etc/.nvmrc
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
  && [ -s "$NVM_DIR/nvm.sh" ]                                                         \
  && . "$NVM_DIR/nvm.sh"                                                              \
  && cd /etc                                                                          \
  && nvm install                                                                      \
  && npm install -g yarn

# Setup NVM and Node sourcing.
# ----------------------------

RUN echo "\n# Source NVM scripts\nsource $NVM_DIR/nvm.sh" >> /etc/bash.bashrc

# Make sure any sudoer can control libs.
# --------------------------------------

RUN sudo chmod a+w -R /usr/local

# Setup user and initialization directory.
# ----------------------------------------

USER ${USER_NAME}
WORKDIR /${USER_NAME}/app

# Setup PATH env variables.
# -------------------------
ENV PATH="/${USER_NAME}/app/vendor/bin:$PATH"

# Install prestissimo for faster composer installs.
# -------------------------------------------------

RUN sudo cp -R /root/.composer /${USER_NAME}/.composer \
  && sudo chown ${USER_NAME}:${GROUP_NAME} -R /${USER_NAME}/.composer

# Update apache version
# ---------------------
RUN sudo add-apt-repository ppa:ondrej/apache2 -y \
  && sudo apt-get update                          \
  && sudo apt-get install apache2 -y   

# Configure entrypoint.
# ---------------------
COPY ./entrypoint.sh /etc/entrypoint.sh
RUN sudo chmod +x /etc/entrypoint.sh

# CMD ["/bin/bash"]
# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
# ENTRYPOINT ["/etc/entrypoint.sh"]