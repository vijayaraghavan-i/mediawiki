FROM centos:centos8

ARG MEDIAWIKI_VERSION

ARG MEDIAWIKI_SUBVERSION

RUN dnf -y update && \
    dnf -y install httpd php php-mysqlnd php-gd php-xml php-mbstring php-json && \
    curl -o /tmp/mediawiki.tar.gz https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.${MEDIAWIKI_SUBVERSION}.tar.gz && \
    tar -C /var/www/html --strip 1 -zxf /tmp/mediawiki.tar.gz && \
    mkdir -p /run/php-fpm && \
    chown -R apache.apache /var/www/html/*

ADD run-httpd.sh /run-httpd.sh

RUN chmod -v +x /run-httpd.sh

EXPOSE 80