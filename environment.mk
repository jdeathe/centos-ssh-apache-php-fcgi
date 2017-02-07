# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
DOCKER_USER := jdeathe
DOCKER_IMAGE_NAME := centos-ssh-apache-php-fcgi
SHPEC_ROOT := test/shpec

# Tag validation patterns
DOCKER_IMAGE_TAG_PATTERN := ^(latest|centos-6|((1|centos-6-1)\.[0-9]+\.[0-9]+))$
DOCKER_IMAGE_RELEASE_TAG_PATTERN := ^(1|centos-6-1)\.[0-9]+\.[0-9]+$

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

# Docker image/container settings
DOCKER_CONTAINER_OPTS ?=
DOCKER_IMAGE_TAG ?= latest
DOCKER_NAME ?= apache-php.pool-1.1.1
DOCKER_PORT_MAP_TCP_22 ?= NULL
DOCKER_PORT_MAP_TCP_80 ?= 8080
DOCKER_PORT_MAP_TCP_443 ?= 9443
DOCKER_PORT_MAP_TCP_8443 ?= NULL
DOCKER_RESTART_POLICY ?= always

# Docker build --no-cache parameter
NO_CACHE ?= false

# Directory path for release packages
DIST_PATH ?= ./dist

# ------------------------------------------------------------------------------
# Application container configuration
# ------------------------------------------------------------------------------
SSH_AUTHORIZED_KEYS ?=
SSH_AUTOSTART_SSHD ?= false
SSH_AUTOSTART_SSHD_BOOTSTRAP ?= false
SSH_CHROOT_DIRECTORY ?= %h
SSH_INHERIT_ENVIRONMENT ?= false
SSH_SUDO ?= ALL=(ALL) ALL
SSH_USER ?= app-admin
SSH_USER_FORCE_SFTP ?= false
SSH_USER_HOME ?= /home/%u
SSH_USER_PASSWORD ?=
SSH_USER_PASSWORD_HASHED ?= false
SSH_USER_SHELL ?= /bin/bash
SSH_USER_ID ?= 500:500
# ------------------------------------------------------------------------------
APACHE_CONTENT_ROOT ?= /var/www/app
APACHE_CUSTOM_LOG_FORMAT ?= combined
APACHE_CUSTOM_LOG_LOCATION ?= var/log/apache_access_log
APACHE_ERROR_LOG_LOCATION ?= var/log/apache_error_log
APACHE_ERROR_LOG_LEVEL ?= warn
APACHE_EXTENDED_STATUS_ENABLED ?= false
APACHE_HEADER_X_SERVICE_UID ?= {{HOSTNAME}}
APACHE_LOAD_MODULES ?= authz_user_module log_config_module expires_module deflate_module headers_module setenvif_module mime_module status_module dir_module alias_module version_module
APACHE_OPERATING_MODE ?= production
APACHE_MOD_SSL_ENABLED ?= false
APACHE_MPM ?= worker
APACHE_PUBLIC_DIRECTORY ?= public_html
APACHE_RUN_GROUP ?= app-www
APACHE_RUN_USER ?= app-www
APACHE_SERVER_ALIAS ?=
APACHE_SERVER_NAME ?=
APACHE_SYSTEM_USER ?= app
PHP_OPTIONS_DATE_TIMEZONE ?= UTC
