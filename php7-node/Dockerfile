FROM mobingi/ubuntu-apache2-php7:7.2
MAINTAINER Taller Development Team <dev@taller.net.br>

# Install dependencies.
# ---------------------

RUN apt-get update -y             \
  && apt-get install -y           \
  bash-completion                 \
  build-essential                 \
  bzip2                           \
  ca-certificates                 \
  cron                            \
  curl                            \
  git                             \
  gzip                            \
  htop                            \
  imagemagick                     \
  iputils-ping                    \
  libfontconfig1                  \
  libjpeg-dev                     \
  libpng12-dev                    \
  libpq-dev                       \
  locales                         \
  mysql-client                    \
  nano                            \
  netcat                          \
  openconnect                     \
  php7.2-soap                     \
  php7.2-sqlite3                  \
  php-xdebug                      \
  python-software-properties      \
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
  && rm -rf /var/lib/apt/lists/*  \
  && rm -rf /tmp/*                \
  && rm -rf /var/tmp/*

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
  && mv composer.phar /usr/local/bin/composer                         \
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
  >> /etc/php/7.2/apache2/php.ini" \
  && sudo phpdismod xdebug

# Apache2 configs.
# -------------
COPY ./000-default.conf /etc/apache2/sites-available/

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
CMD ["/bin/bash"]
ENTRYPOINT ["/etc/entrypoint.sh"]
