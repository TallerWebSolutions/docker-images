FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get install -y --no-install-recommends 	\
			apache2                                       							\
			curl 																												\
			software-properties-common                    							\
			cron                                          							\
			&& apt-get clean                              							\
			&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends 	\
			libapache2-mod-php7.3                                    		\
			php7.3                                                   		\
			php7.3-cli                                               		\
			php7.3-curl                                              		\
			php7.3-dev                                               		\
			php7.3-gd                                                		\
			php7.3-imap                                              		\
			php7.3-mbstring                                          		\
			php7.3-mysql                                             		\
			php7.3-pgsql                                             		\
			php7.3-pspell                                            		\
			php7.3-xml                                               		\
			php7.3-xmlrpc                                            		\
			php-apcu                                                 		\
			php-memcached                                            		\
			php-pear                                                 		\
			php-redis                                                		\
			&& apt-get clean                                         		\
			&& rm -fr /var/lib/apt/lists/*

ADD composerinstall.sh ./composerinstall.sh
RUN ./composerinstall.sh
RUN a2enmod rewrite
COPY ./apache-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html
EXPOSE 80
