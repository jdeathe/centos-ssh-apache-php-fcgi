# =============================================================================
# jdeathe/centos-ssh-apache-php-fcgi
#
# CentOS-6, Apache 2.2, PHP 5.3, PHP memcached 1.0, PHP APC 3.1, Composer
# 
# =============================================================================
FROM jdeathe/centos-ssh-apache-php

MAINTAINER James Deathe <james.deathe@gmail.com>

# -----------------------------------------------------------------------------
# FastCGI support
# -----------------------------------------------------------------------------
RUN yum --setopt=tsflags=nodocs -y install \
	fcgi \
	mod_fcgid \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

# -----------------------------------------------------------------------------
# Add a "Message of the Day" to help identify container if logging in via SSH
# -----------------------------------------------------------------------------
RUN echo '[ CentOS-6 / Apache / PHP (FastCGI) ]' > /etc/motd

# -----------------------------------------------------------------------------
# Apache mime_magic module should be disabled with FastCGI
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~^LoadModule mime_magic_module modules/mod_mime_magic.so~#LoadModule mime_magic_module modules/mod_mime_magic.so~g' \
	/etc/httpd/conf/httpd.conf

# -----------------------------------------------------------------------------
# Enable the pathinfo fix
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~^;cgi.fix_pathinfo=1~cgi.fix_pathinfo = 1~g' \
	/etc/php.ini

# -----------------------------------------------------------------------------
# Enable Apache MPM worker
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~#HTTPD=/usr/sbin/httpd.worker~HTTPD=/usr/sbin/httpd.worker~g' \
	/etc/sysconfig/httpd

# -----------------------------------------------------------------------------
# Disable mod_php
# -----------------------------------------------------------------------------
RUN mv /etc/httpd/conf.d/php.conf /etc/httpd/conf.d/php.conf.off
RUN touch /etc/httpd/conf.d/php.conf
RUN chmod 444 /etc/httpd/conf.d/php.conf

# -----------------------------------------------------------------------------
# Add the PHP Wrapper script
# -----------------------------------------------------------------------------
RUN mkdir -p /var/www/app/bin
ADD var/www/app/bin/php-wrapper /var/www/app/bin/

# -----------------------------------------------------------------------------
# Replace the PHP Standard bootstrap
# -----------------------------------------------------------------------------
ADD etc/services-config/httpd/apache-bootstrap.conf /etc/services-config/httpd/
RUN ln -sf /etc/services-config/httpd/apache-bootstrap.conf /etc/apache-bootstrap.conf

ADD etc/apache-bootstrap /etc/
RUN chmod +x /etc/apache-bootstrap

# -----------------------------------------------------------------------------
# Set permissions (app:app-www === 501:502)
# -----------------------------------------------------------------------------
RUN chmod -R 750 /var/www/app/bin

# -----------------------------------------------------------------------------
# Add to the template directory
# -----------------------------------------------------------------------------
RUN cp -rpf /var/www/app/bin /var/www/.app-skel/bin

# -----------------------------------------------------------------------------
# Copy files into place
# -----------------------------------------------------------------------------
ADD etc/services-config/httpd/conf.d/fcgid.conf /etc/services-config/httpd/conf.d/
RUN ln -sf /etc/services-config/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.conf

EXPOSE 80 8443 443

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]