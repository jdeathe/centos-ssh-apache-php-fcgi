# =============================================================================
# jdeathe/centos-ssh-apache-php-fcgi
#
# CentOS-6, Apache 2.2, PHP 5.3, PHP Memcached 1.0, PHP APC 3.1.
# 
# =============================================================================
FROM jdeathe/centos-ssh-apache-php:1.10.0

MAINTAINER James Deathe <james.deathe@gmail.com>

# -----------------------------------------------------------------------------
# FastCGI support
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
	&& yum -y erase \
		php-5.3.3-49.el6 \
	&& yum -y install \
		--setopt=tsflags=nodocs \
		--disableplugin=fastestmirror \
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
ADD src/opt/scmi \
	/opt/scmi/
ADD src/etc/systemd/system \
	/etc/systemd/system/

# -----------------------------------------------------------------------------
# Package installation
# -----------------------------------------------------------------------------
RUN sed -i \
	-e 's~^description =.*$~description = "This CentOS / Apache / PHP-CGI (FastCGI) service is running in a container."~' \
	${PACKAGE_PATH}/etc/views/index.ini

# -----------------------------------------------------------------------------
# Set default environment variables used to configure the service container
# -----------------------------------------------------------------------------
ENV APACHE_MPM="worker"

# -----------------------------------------------------------------------------
# Set image metadata
# -----------------------------------------------------------------------------
ARG RELEASE_VERSION="1.9.0"
LABEL \
	install="docker run \
--rm \
--privileged \
--volume /:/media/root \
--env BASH_ENV="" \
--env ENV="" \
jdeathe/centos-ssh-apache-php-fcgi:${RELEASE_VERSION} \
/usr/sbin/scmi install \
--chroot=/media/root \
--name=\${NAME} \
--tag=${RELEASE_VERSION}" \
	uninstall="docker run \
--rm \
--privileged \
--volume /:/media/root \
--env BASH_ENV="" \
--env ENV="" \
jdeathe/centos-ssh-apache-php-fcgi:${RELEASE_VERSION} \
/usr/sbin/scmi uninstall \
--chroot=/media/root \
--name=\${NAME} \
--tag=${RELEASE_VERSION}" \
	org.deathe.name="centos-ssh-apache-php-fcgi" \
	org.deathe.version="${RELEASE_VERSION}" \
	org.deathe.release="jdeathe/centos-ssh-apache-php-fcgi:${RELEASE_VERSION}" \
	org.deathe.license="MIT" \
	org.deathe.vendor="jdeathe" \
	org.deathe.url="https://github.com/jdeathe/centos-ssh-apache-php-fcgi" \
	org.deathe.description="CentOS-6 6.9 x86_64 - Apache 2.2, PHP-CGI 5.3 (FastCGI), PHP memcached 1.0, PHP APC 3.1."

CMD ["/usr/sbin/httpd-startup", "/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]