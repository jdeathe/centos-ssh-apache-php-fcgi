# Change Log

## 2 - centos-7

Summary of release changes.

### 2.2.3 - 2019-10-08

- Deprecate Makefile target `logs-delayed`; replaced with `logsdef`.
- Updates source image to [2.6.1](https://github.com/jdeathe/centos-ssh/releases/tag/2.6.1).
- Updates `httpd` packages to 2.4.6-90.
- Updates `mod_fcgid` package to 2.3.9-6.
- Updates `mod_ssl` package to 2.4.6-90.
- Updates `test/health_status` helper script with for consistency.
- Updates Makefile target `logs` to accept `[OPTIONS]` (e.g `make -- logs -ft`).
- Updates info/error output for consistency.
- Updates healthcheck failure messages to remove EOL character that is rendered in status response.
- Updates wrapper script; only emit "waiting on" info message if bootstrap hasn't completed.
- Updates ordering of Tags and respective Dockerfile links in README.md for readability.
- Updates session test cases; replace PHP memcached session store with redis.
- Adds improved test workflow; added `test-setup` target to Makefile.
- Adds Makefile target `logsdef` to handle deferred logs output within a target chain.
- Adds `/docs` directory for supplementary documentation and simplify README.
- Adds test case for Apache `DirectoryIndex` default.
- Fixes validation failure of 0 second --timeout value in `test/health_status`.
- Removes PHP-FPM status handler configuration from the Apache server-status drop-in.

### 2.2.2 - 2019-08-05

- Updates php-hello-world to [0.14.0](https://github.com/jdeathe/php-hello-world/releases/tag/0.14.0).
- Adds PHP 5 applicable session settings into service configuration.
- Adds configuration file replacement of placeholders for Xdebug's `DBGP_IDEKEY`.

### 2.2.1 - 2019-07-28

- Updates php-hello-world to [0.13.0](https://github.com/jdeathe/php-hello-world/releases/tag/0.13.0).
- Updates screenshots in README.
- Adds setting PHP `date.timezone` to `PHP_OPTIONS_DATE_TIMEZONE` into service configuration; removes dependency on app package configuration.
- Adds session PHP settings into service configuration; removes dependency on app package configuration.

### 2.2.0 - 2019-07-20

- Updates source image to [2.6.0](https://github.com/jdeathe/centos-ssh/releases/tag/2.6.0).
- Updates php-hello-world to [0.12.0](https://github.com/jdeathe/php-hello-world/releases/tag/0.12.0).
- Updates description in centos-ssh-apache-php-fcgi.register@.service.
- Updates Apache configuration to use DSO Module identifiers for consistency.
- Updates CHANGELOG.md to simplify maintenance.
- Updates README.md to simplify contents and improve readability.
- Updates README-short.txt to apply to all image variants.
- Updates Dockerfile `org.deathe.description` metadata LABEL for consistency + include PHP redis module.
- Updates wrapper to set httpd ErrorLog to `/dev/stderr` instead of `/dev/stdout`.
- Updates supervisord configuration to send error log output to stderr.
- Updates bootstrap timer to use UTC date timestamps.
- Updates bootstrap supervisord configuration file/priority to `20-httpd-bootstrap.conf`/`20`.
- Updates httpd wrapper supervisord configuration file/priority to `70-httpd-wrapper.conf`/`70`.
- Fixes bootstrap; ensure user creation occurs before setting ownership with user.
- Fixes docker host connection status check in Makefile.
- Adds `PACKAGE_PATH` placeholder/variable replacement in bootstrap of configuration files.
- Adds `inspect`, `reload` and `top` Makefile targets.
- Adds improved `clean` Makefile target; includes exited containers and dangling images.
- Adds `SYSTEM_TIMEZONE` handling to Makefile, scmi, systemd unit and docker-compose templates.
- Adds system time zone validation to healthcheck.
- Adds lock/state file to bootstrap/wrapper scripts.
- Adds `php-wrapper` and `fcgid.conf` as part of the service; removing dependency on the php-hello-world app.
- Removes unused `DOCKER_PORT_MAP_TCP_22` variable from environment includes.
- Removes support for long image tags (i.e. centos-7-2.x.x).
- Removes `APACHE_AUTOSTART_HTTPD_BOOTSTRAP`, replaced with `ENABLE_HTTPD_BOOTSTRAP`.
- Removes `APACHE_AUTOSTART_HTTPD_WRAPPER`, replaced with `ENABLE_HTTPD_WRAPPER`.

### 2.1.0 - 2019-04-14

- Updates `elinks` package to elinks-0.12-0.37.pre6.el7.0.1.
- Updates source image to [2.5.1](https://github.com/jdeathe/centos-ssh/releases/tag/2.5.1).
- Updates and restructures Dockerfile.
- Updates container naming conventions and readability of `Makefile`.
- Fixes issue with unexpected published port in run templates when `DOCKER_PORT_MAP_TCP_80`, `DOCKER_PORT_MAP_TCP_443` or `DOCKER_PORT_MAP_TCP_8443` is set to an empty string or 0.
- Fixes binary paths in systemd unit files for compatibility with both EL and Ubuntu hosts.
- Fixes link to OpenSSL ciphers manual page.
- Adds consideration for event lag into test cases for unhealthy health_status events.
- Adds port incrementation to Makefile's run template for container names with an instance suffix.
- Adds placeholder replacement of `RELEASE_VERSION` docker argument to systemd service unit template.
- Adds improvement to pull logic in systemd unit install template.
- Adds `SSH_AUTOSTART_SUPERVISOR_STDOUT` with a value "false", disabling startup of `supervisor_stdout`.
- Adds error messages to healthcheck script and includes supervisord check.
- Adds improved logging output.
- Adds images directory `.dockerignore` to reduce size of build context.
- Adds docker-compose configuration example.
- Adds improved lock/state file implementation between bootstrap and wrapper scripts.
- Adds graceful stop signals the supervisord configuration for `httpd-wrapper`.
- Removes use of `/etc/services-config` paths.
- Removes the unused group element from the default container name.
- Removes the node element from the default container name.
- Removes unused environment variables from Makefile and scmi configuration.
- Removes X-Fleet section from etcd register template unit-file.
- Removes unnecessary configuration file `/etc/httpd-bootstrap.conf`.
- Removes systemd health reporting from PHP-FPM configuration.
- Removes unnecessarily setting random passwords for system accounts during bootstrap; lock instead.
- Removes requirement for `/usr/sbin/httpd-startup`.

### 2.0.1 - 2018-12-08

- Updates source image to [2.4.1](https://github.com/jdeathe/centos-ssh/releases/tag/2.4.1).
- Updates `httpd` packages to 2.4.6-88.
- Updates `php` packages to 5.4.16-46.
- Updates php-hello-world to [0.11.0](https://github.com/jdeathe/php-hello-world/releases/tag/0.11.0).
- Adds `php-pecl-redis` package to support Redis.

### 2.0.0 - 2018-10-14

- Initial release