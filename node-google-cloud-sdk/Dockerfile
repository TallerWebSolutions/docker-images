FROM messari/google-cloud-sdk:latest

ENV GOOGLE_APPLICATION_CREDENTIALS /tmp/certs/svc_account.json

WORKDIR /taller/app

# Install dependencies.
# ---------------------
RUN apt-get update -y               \
  && apt-get install -y           \
  bash-completion                 \
  build-essential                 \
  bzip2                           \
  ca-certificates                 \
  curl                            \
  git                             \
  gzip                            \
  htop                            \
  nano                            \
  sudo                            \
  ssh                             \
  tig                             \
  vim                             \
  wget                            \
  --no-install-recommends         \
  && apt-get clean                \
  && rm -rf /var/lib/apt/lists/*  \
  && rm -rf /tmp/*                \
  && rm -rf /var/tmp/*

# Installs SQL Cloud Proxy to allow db access from local
# -------------------------
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy \
  && mv cloud_sql_proxy /usr/local/bin \
  && chmod +x /usr/local/bin/cloud_sql_proxy \
  && mkdir /cloudsql

# Configure Node related environment.
# -----------------------------------

ENV NVM_DIR /usr/local/nvm
ARG VERSION=stable
ENV VERSION ${VERSION}


# Install Node.
# -------------

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
  && [ -s "$NVM_DIR/nvm.sh" ]                                                         \
  && . "$NVM_DIR/nvm.sh"                                                              \
  && nvm install ${VERSION}                                                           \
  && npm install -g yarn


# Setup NVM and Node sourcing.
# ----------------------------

RUN echo "\n# Source NVM scripts\nsource $NVM_DIR/nvm.sh" >> /etc/bash.bashrc


# Make sure any sudoer can control libs.
# --------------------------------------

RUN sudo chmod a+w -R /usr/local

EXPOSE 8080