# =============================================================================
# jdeathe/centos-ssh-apache-php-fcgi
#
# CentOS-6, Apache 2.2, PHP 5.3, PHP Memcached 1.0, PHP APC 3.1.
# 
# =============================================================================
FROM jdeathe/centos-ssh-apache-php:centos-6-1.6.0

MAINTAINER James Deathe <james.deathe@gmail.com>

# -----------------------------------------------------------------------------
# FastCGI support
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
	&& yum -y erase \
		php-5.3.3-48.el6_8 \
	&& yum --setopt=tsflags=nodocs -y install \
		fcgi-2.4.0-12.el6 \
		mod_fcgid-2.3.9-1.el6 \
	&& yum versionlock add \
		fcgi \
		mod_fcgid \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

# -----------------------------------------------------------------------------
# Copy files into place
# -----------------------------------------------------------------------------
ADD etc/services-config/httpd/conf.d/fcgid.conf \
	/etc/services-config/httpd/conf.d/
RUN ln -sf \
	/etc/services-config/httpd/conf.d/fcgid.conf \
	/etc/httpd/conf.d/fcgid.conf

# -----------------------------------------------------------------------------
# Set default environment variables used to configure the service container
# -----------------------------------------------------------------------------
ENV HTTPD="/usr/sbin/httpd.worker"

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]