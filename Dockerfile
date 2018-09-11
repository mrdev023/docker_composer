FROM php:7.2.9-cli

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip libpng-dev zlib1g-dev libicu-dev bash

# Install extensions
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install intl
RUN docker-php-ext-install exif

# Enable extensions
RUN docker-php-ext-enable zip
RUN docker-php-ext-enable gd
RUN docker-php-ext-enable intl
RUN docker-php-ext-enable exif

RUN curl --silent --show-error https://getcomposer.org/installer | php

RUN echo 'alias composer="php /composer.phar"' >> ~/.bashrc

RUN mkdir /app

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

CMD ["composer"]
