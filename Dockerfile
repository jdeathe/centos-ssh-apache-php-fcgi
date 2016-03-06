# =============================================================================
# jdeathe/centos-ssh-apache-php-fcgi
#
# CentOS-6, Apache 2.2, PHP 5.3, PHP Memcached 1.0, PHP APC 3.1.
# 
# =============================================================================
FROM jdeathe/centos-ssh-apache-php:centos-6-1.4.3

MAINTAINER James Deathe <james.deathe@gmail.com>

# -----------------------------------------------------------------------------
# FastCGI support
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
	&& yum --setopt=tsflags=nodocs -y install \
	fcgi-2.4.0-12.el6 \
	mod_fcgid-2.3.9-1.el6 \
	&& yum versionlock add \
	fcgi \
	mod_fcgid \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

# -----------------------------------------------------------------------------
# Apache mime_magic module should be disabled with FastCGI
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~^LoadModule mime_magic_module ~#LoadModule mime_magic_module ~g' \
	/etc/httpd/conf/httpd.conf

# -----------------------------------------------------------------------------
# Enable the pathinfo fix
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~^;cgi.fix_pathinfo=1$~cgi.fix_pathinfo=1~g' \
	/etc/php.ini

# -----------------------------------------------------------------------------
# Disable mod_php
# -----------------------------------------------------------------------------
RUN mv /etc/httpd/conf.d/php.conf /etc/httpd/conf.d/php.conf.off \
	&& touch /etc/httpd/conf.d/php.conf \
	&& chmod 444 /etc/httpd/conf.d/php.conf

# -----------------------------------------------------------------------------
# Add the PHP Wrapper script
# -----------------------------------------------------------------------------
ADD var/www/app-bin/php-wrapper /var/www/app-bin/
RUN chmod -R 750 /var/www/app-bin

# -----------------------------------------------------------------------------
# Copy files into place
# -----------------------------------------------------------------------------
ADD etc/apache-bootstrap /etc/
ADD etc/services-config/httpd/apache-bootstrap.conf /etc/services-config/httpd/
ADD etc/services-config/httpd/conf.d/fcgid.conf /etc/services-config/httpd/conf.d/
RUN ln -sf /etc/services-config/httpd/apache-bootstrap.conf /etc/apache-bootstrap.conf \
	&& ln -sf /etc/services-config/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.conf \
	&& chmod +x /etc/apache-bootstrap

# -----------------------------------------------------------------------------
# Set default environment variables used to identify the service container
# -----------------------------------------------------------------------------
# ENV SERVICE_UNIT_APP_GROUP app-1
# ENV SERVICE_UNIT_LOCAL_ID 1
# ENV SERVICE_UNIT_INSTANCE 1

# -----------------------------------------------------------------------------
# Set default environment variables used to configure the service container
# -----------------------------------------------------------------------------
# ENV APACHE_CONTENT_ROOT /var/www/${PACKAGE_NAME}
# ENV APACHE_CUSTOM_LOG_FORMAT combined
# ENV APACHE_CUSTOM_LOG_LOCATION ${APACHE_CONTENT_ROOT}/var/log/apache_access_log
# ENV APACHE_ERROR_LOG_LOCATION ${APACHE_CONTENT_ROOT}/var/log/apache_error_log
# ENV APACHE_ERROR_LOG_LEVEL warn
# ENV APACHE_EXTENDED_STATUS_ENABLED false
# ENV APACHE_LOAD_MODULES "authz_user_module log_config_module expires_module deflate_module headers_module setenvif_module mime_module status_module dir_module alias_module"
# ENV APACHE_MOD_SSL_ENABLED false
# ENV APACHE_PUBLIC_DIRECTORY public_html
# ENV APACHE_RUN_GROUP app-www
# ENV APACHE_RUN_USER app-www
# ENV APACHE_SERVER_ALIAS ""
# ENV APACHE_SERVER_NAME app-1.local
# ENV APACHE_SUEXEC_USER_GROUP false
# ENV APACHE_SYSTEM_USER app
ENV HTTPD /usr/sbin/httpd.worker
# ENV PACKAGE_PATH ${PACKAGE_PATH}
# ENV PHP_OPTIONS_DATE_TIMEZONE UTC

# EXPOSE 80 8443 443

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]