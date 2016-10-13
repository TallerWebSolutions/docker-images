FROM debian:jessie
MAINTAINER Taller Devs <dev@taller.net.br>

# Configure environment.
# ----------------------

ENV DEBIAN_FRONTEND noninteractive  # Ignore apt-get interactions.
ENV NPM_CONFIG_LOGLEVEL info        # Show better information from npm.


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


# Install Node.
# -------------

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
 && export NVM_DIR="/root/.nvm"                                                         \
 && [ -s "$NVM_DIR/nvm.sh" ]                                                            \
 && . "$NVM_DIR/nvm.sh"                                                                 \
 && nvm install v6.8.0
