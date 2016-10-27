FROM debian:jessie
MAINTAINER Taller Development Team <dev@taller.net.br>

# Configure Debian environment.
# -----------------------------

ENV DEBIAN_FRONTEND noninteractive


# Install dependencies.
# ---------------------

RUN apt-get update &&          \
    apt-get install -y         \
    sudo                       \
    ssh                        \
    curl                       \
    wget                       \
    gzip                       \
    bzip2                      \
    locales                    \
    netcat                     \
    xz-utils                   \
    htop                       \
    git                        \
    vim                        \
    nano                       \
    bash-completion            \
    libfontconfig1             \
    build-essential            \
    python-software-properties \
    ca-certificates            \
    rsync                      \
    --no-install-recommends


# Configure Node related environment.
# -----------------------------------

ENV NVM_DIR /usr/local/nvm
ARG VERSION=stable
ENV VERSION ${VERSION}


# Install Node.
# -------------


RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
 && [ -s "$NVM_DIR/nvm.sh" ]                                                            \
 && . "$NVM_DIR/nvm.sh"                                                                 \
 && nvm install ${VERSION}                                                              \
 && npm install -g yarn


# Setup NVM and Node sourcing.
# ----------------------------

RUN echo "\n# Source NVM scripts\nsource $NVM_DIR/nvm.sh" >> /etc/bash.bashrc
RUN sudo chmod a+w -R /usr/local
