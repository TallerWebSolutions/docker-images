FROM debian:jessie
MAINTAINER Taller Development Team <dev@taller.net.br>

# Configure environment.
# ----------------------

ENV DEBIAN_FRONTEND noninteractive
ENV NVM_DIR /usr/local/nvm


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
 && [ -s "$NVM_DIR/nvm.sh" ]                                                            \
 && . "$NVM_DIR/nvm.sh"                                                                 \
 && nvm install v6.8.0


# Setup entrypoint.
# -----------------

COPY ./entrypoint.sh /etc/entrypoint.sh
RUN sudo chmod +x /etc/entrypoint.sh
CMD ["/bin/bash"]
ENTRYPOINT ["/etc/entrypoint.sh"]
