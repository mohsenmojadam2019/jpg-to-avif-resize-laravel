FROM dpokidov/imagemagick:latest

ARG PHP_IM_VERSION=3.4.4
ARG PHP_VERSION=7.4

RUN apt-get update && apt-get install -y gnupg2 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    echo -n 'deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main' > /etc/apt/sources.list.d/ondrej-ubuntu-php-bionic.list && apt-get update && \
    apt-get install -y php${PHP_VERSION}-dev && \
    curl -L https://github.com/Imagick/imagick/archive/${PHP_IM_VERSION}.tar.gz -o imagick-${PHP_IM_VERSION}.tar.gz && \
    tar -zxvf imagick-${PHP_IM_VERSION}.tar.gz && rm imagick-${PHP_IM_VERSION}.tar.gz && \
    cd imagick-${PHP_IM_VERSION} && phpize && ./configure && make && \
    mkdir /phpmods && cp -r modules /phpmods && \
    cd .. && \
    rm -rf imagick-${PHP_IM_VERSION} && \
    ldconfig /usr/local/lib && \
    # Cleanup
    apt-get remove --autoremove --purge -y gnupg2 php${PHP_VERSION}-dev && \
    rm -rf /var/lib/apt/lists/*
