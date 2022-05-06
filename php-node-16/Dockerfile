FROM ubuntu:20.04
LABEL Taller Development Team <dev@taller.net.br>

ARG DEBIAN_FRONTEND=noninteractive
ARG VERSION=7.4
ENV VERSION ${VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils software-properties-common gpg-agent \
  && apt-get clean                \
  && rm -rf /tmp/*                \
  && rm -rf /var/tmp/*            \
  && rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
  && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/apache2 \
  && apt-get clean                \
  && rm -rf /tmp/*                \
  && rm -rf /var/tmp/*            \
  && rm -fr /var/lib/apt/lists/*

# Install dependencies.
# ---------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
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
  libapache2-mod-php${VERSION}    \
  php-pear                        \
  php${VERSION}                   \
  php${VERSION}-common            \
  php${VERSION}-mysql             \
  php${VERSION}-xml               \
  php${VERSION}-xmlrpc            \
  php${VERSION}-curl              \
  php${VERSION}-gd                \
  php${VERSION}-imagick           \
  php${VERSION}-cli               \
  php${VERSION}-dev               \
  php${VERSION}-imap              \
  php${VERSION}-mbstring          \
  php${VERSION}-opcache           \
  php${VERSION}-soap              \
  php${VERSION}-zip               \
  php${VERSION}-intl              \
  php${VERSION}-bcmath            \
  php${VERSION}-pgsql             \
  php${VERSION}-pspell            \
  php${VERSION}-apcu              \
  php${VERSION}-memcached         \
  php${VERSION}-redis             \
  php${VERSION}-xdebug            \
  php${VERSION}-soap              \
  php${VERSION}-sqlite3           \
  apache2                         \
  rsync                           \
  sudo                            \
  ssh                             \
  tig                             \
  vim                             \
  xz-utils                        \
  wget                            \
  unzip                           \
  --no-install-recommends         \
  && apt-get remove --purge build-essential -y \
  && apt-get autoremove --purge -y \
  && apt-get clean                \
  && rm -rf /tmp/*                \
  && rm -rf /var/tmp/*            \
  && rm -fr /var/lib/apt/lists/*


# Apache2 configs.
# -------------
COPY ./default.conf /etc/apache2/sites-available/
RUN a2ensite default.conf \
  && a2dissite 000-default.conf \
  && a2enmod php${VERSION} \
  && a2enmod rewrite

# Configure Composer related environment.
# ---------------------------------------
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1

#
#
# # Install Composer.
# # -----------------
#
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.26 \
  && mv composer.phar /usr/local/bin/composer \
  && composer global require "hirak/prestissimo:^0.3" \
  && composer clearcache


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
  >> /etc/php/${VERSION}/apache2/php.ini" \
  && sudo phpdismod xdebug

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
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash \
  && [ -s "$NVM_DIR/nvm.sh" ]                                                         \
  && . "$NVM_DIR/nvm.sh"                                                              \
  && cd /etc                                                                          \
  && nvm install                                                                      \
  && npm install -g yarn                                                              \
  && nvm cache clear \
  && npm cache clean --force

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

# Configure entrypoint.
# ---------------------
COPY ./entrypoint.sh /etc/entrypoint.sh
RUN sudo chmod +x /etc/entrypoint.sh
