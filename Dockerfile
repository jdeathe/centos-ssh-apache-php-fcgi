FROM jdeathe/centos-ssh-apache-php:1.12.0

ARG RELEASE_VERSION="1.11.1"

# ------------------------------------------------------------------------------
# - Base install of required packages
# ------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
# Copy files into place
# ------------------------------------------------------------------------------
ADD src /

# ------------------------------------------------------------------------------
# Provisioning
# - Relocate default fcgid configuration to ensure correct loading order
# - Replace placeholders with values in systemd service unit template
# - Set permissions
# ------------------------------------------------------------------------------
RUN cat \
		/etc/httpd/conf.d/fcgid.conf \
		> /etc/httpd/conf.d/00-fcgid.conf \
	&& truncate -s 0 \
		/etc/httpd/conf.d/fcgid.conf \
	&& sed -i \
		-e "s~{{RELEASE_VERSION}}~${RELEASE_VERSION}~g" \
		/etc/systemd/system/centos-ssh-apache-php-fcgi@.service \
	&& chmod 700 \
		/usr/{bin/healthcheck,sbin/httpd-{bootstrap,wrapper}}

# ------------------------------------------------------------------------------
# Package installation
# ------------------------------------------------------------------------------
RUN sed -i \
	-e 's~^description =.*$~description = "This CentOS / Apache / PHP-CGI (FastCGI) service is running in a container."~' \
	${PACKAGE_PATH}/etc/views/index.ini

# ------------------------------------------------------------------------------
# Set default environment variables used to configure the service container
# ------------------------------------------------------------------------------
ENV APACHE_MPM="worker"

# ------------------------------------------------------------------------------
# Set image metadata
# ------------------------------------------------------------------------------
LABEL \
	maintainer="James Deathe <james.deathe@gmail.com>" \
	install="docker run \
--rm \
--privileged \
--volume /:/media/root \
jdeathe/centos-ssh-apache-php-fcgi:${RELEASE_VERSION} \
/usr/sbin/scmi install \
--chroot=/media/root \
--name=\${NAME} \
--tag=${RELEASE_VERSION}" \
	uninstall="docker run \
--rm \
--privileged \
--volume /:/media/root \
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
	org.deathe.description="CentOS-6 6.10 x86_64 - Apache 2.2, PHP-CGI 5.3 (FastCGI), PHP memcached 1.0, PHP APC 3.1."

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
