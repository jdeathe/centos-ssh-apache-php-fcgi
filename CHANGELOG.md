# Change Log

## centos-6

Summary of release changes for Version 1.

CentOS-6 6.10 x86_64, Apache 2.2, PHP-CGI 5.3 (FastCGI), PHP memcached 1.0, PHP APC 3.1.

### 1.13.0 - Unreleased

- Adds `.env` files to `.gitignore` for exclusion from version control.
- Removes unused `DOCKER_PORT_MAP_TCP_22` variable from environment includes.

### 1.12.0 - 2019-04-14

- Updates image source to [1.12.0](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.12.0).
- Adds patched version of `httpd-wrapper` to fix setting user ownership.

### 1.11.1 - 2018-12-08

- Updates image source to [1.11.1](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.11.1).

### 1.11.0 - 2018-09-04

- Updates image source to [1.11.0](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.11.0).

### 1.10.6 - 2018-06-21

- Fixes broken links in the README document.
- Updates image source to [release 1.10.6](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.6).

### 1.10.5 - 2018-05-21

- Updates image source to [release 1.10.5](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.5).

### 1.10.4 - 2018-01-29

- Updates image source to [release 1.10.4](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.4).

### 1.10.3 - 2018-01-16

- Updates image source to [release 1.10.3](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.3).

### 1.10.2 - 2017-12-27

- Updates image source to [release 1.10.2](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.2).

### 1.10.1 - 2017-09-28

- Updates image source to [release 1.10.1](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.1).

### 1.10.0 - 2017-07-16

- Updates image source to [release 1.10.0](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.10.0).
- Fixes issue with missing APACHE_SSL_* environment variables for make,scmi and systemd.
- Adds test case output with improved readability.
- Adds simplified port incrementation handling to systemd unit and make consistent with SCMI.

### 1.9.0 - 2017-02-07

- Updates image source to release 1.9.0.
- Fixes issue with app specific `httpd` configuration requiring the `etc/php.d` directory to exist.
- Adds default Apache modules appropriate for Apache 2.4/2.2 in the bootstrap script for the unlikely case where the values in the environment and configuration file defaults are both unset.
- Updates `README.md` with details of the SCMI install example's prerequisite step of either pulling or loading the image.
- Updates `httpd` and `mod_ssl` packages.
- Fixes noisy certificate generation output in logs during bootstrap when `APACHE_MOD_SSL_ENABLED` is `true`.
- Changes `APACHE_SERVER_ALIAS` to a default empty value for `Makefile`, `scmi` and `systemd` templates which is the existing `Dockerfile` default.
- Changes default `APACHE_SERVER_NAME` to unset and use the container's hostname for the Apache ServerName.
- Fixes `scmi` install/uninstall examples and Dockerfile `LABEL` install/uninstall templates to prevent the `X-Service-UID` header being populated with the hostname of the ephemeral container used to run `scmi`.
- Adds feature to allow both `APACHE_SERVER_NAME` and `APACHE_SERVER_ALIAS` to contain the `{{HOSTNAME}}` placeholder which is replaced on startup with the container's hostname.
- Removes environment variable re-mappings that are no longer in use: `APP_HOME_DIR`, `APACHE_SUEXEC_USER_GROUP`, `DATE_TIMEZONE`, `SERVICE_USER`, `SUEXECUSERGROUP`, `SERVICE_UID`.
- Changes Apache configuration so that `NameVirtualHost` and `Listen` are separated out from `VirtualHost`.
- Adds further information on the use of `watch` to monitor `server-status`.
- Changes the auto-generated self-signed certificate to include hosts from `APACHE_SERVER_NAME` and `APACHE_SERVER_ALIAS` via subjectAltName.

### 1.8.1 - 2017-01-29

- Updates image source to release 1.8.2 including required Makefile and environment changes.
- Adds test cases for FastCGI operation.
- Adds a Change Log.
- Adds support for semantic release tag version numbers.
- Changes description to PHP-CGI instead of PHP.

### 1.8.0 - 2016-10-25

- Changes source to release 1.8.0.
- Adds installation of php-hello-world app from [external release source](https://github.com/jdeathe/php-hello-world/releases).
- Adds UseCanonicalName On httpd setting.
- Adds reduced Dockerfile build layers for installing PHP app package.
- Adds startup script `/usr/sbin/httpd-startup` used to initialise environment variables; paths that are relative are expanded to absolute and the hostname placeholder is replaced with the container's hostname. This logic has been moved out of the Apache wrapper script so it can be set globally and made available when accessing the container interactively.
- Adds package php-hello-world 0.4.0.
- Adds update browser screenshots to documentation.

### 1.7.2 - 2016-10-02

- Adds Makefile help target with usage instructions.
- Splits up the Makefile targets into internal and public types.
- Adds correct `scmi` path in usage instructions.
- Changes `PACKAGE_PATH` to `DIST_PATH` in line with the Makefile environment include. Not currently used by `scmi` but changing for consistency.
- Changes `DOCKER_CONTAINER_PARAMETERS_APPEND` to `DOCKER_CONTAINER_OPTS` for usability. This is a potentially breaking change that could affect systemd service configurations if using the Environment variable in a drop-in customisation. However, if using the systemd template unit-files it should be pinned to a specific version tag. The Makefile should only be used for development/testing and usage in `scmi` is internal only as the `--setopt` parameter is used to build up the optional container parameters. 
- Removes X-Fleet section from template unit-file.

### 1.7.1 - 2016-09-30

- Updates source to release 1.7.2.
- Replaces `PACKAGE_PATH` with `DIST_PATH` in Makefile. The package output directory created will be `./dist` instead of `./packages/jdeathe`.
- Apache VirtualHost configuration has been simplified to only require a single certificate bundle file (`/etc/pki/tls/certs/localhost.crt`) in PEM format.
- Adds `APACHE_SSL_CERTIFICATE` to allow the operator to add a PEM, (and optionally base64), encoded certificate bundle (inclusive of key + certificate + intermediate certificate. Base64 encoding of the PEM file contents is recommended.
- Adds `APACHE_SSL_CIPHER_SUITE` to allow the operator to define a custom CipherSuite.
- Adds `APACHE_SSL_PROTOCOL` to allow the operator to add/remove SSL protocol support.
- Adds usage instructions for `APACHE_SSL_CERTIFICATE`, `APACHE_SSL_CIPHER_SUITE` and `APACHE_SSL_PROTOCOL`.
- Removes requirement to pass php package name to the php-wrapper - feature was undocumented and unused.
- Removes MySQL legacy-linked environment variable population and handling.
- Adds correct path to `scmi` in image metadata to allow `atomic install` to complete successfully.

#### Known Issues

The Makefile install (create) target fails when a `APACHE_SSL_CERTIFICATE` is set as multiline formatted string in the environment as follows.

```
$ export APACHE_SSL_CERTIFICATE="$(
  < "/etc/pki/tls/certs/localhost.crt"
)"
```

The recommended way to set the certificate value is to base64 encode it as a string value.

Mac OSX:

```
$ export APACHE_SSL_CERTIFICATE="$(
  base64 -i "/etc/pki/tls/certs/localhost.crt"
)"
```

Linux:

```
$ export APACHE_SSL_CERTIFICATE="$(
  base64 -w 0 -i "/etc/pki/tls/certs/localhost.crt"
)"
```

### 1.7.0 - 2016-09-14

- Updates source tag to 1.7.1.
- Adds `scmi` and metadata for atomic install/uninstall usage.
- Removes deprecated run.sh and build.sh helper scripts. These have been replaced with the make targets `make` (or `make build`) and `make install start`.
- Removes support for and documentation on configuration volumes. These can still be implemented by making use of the `DOCKER_CONTAINER_PARAMETERS_APPEND` environment variable or using the `scmi` option `--setopt` to append additional docker parameters to the default docker create template.
- Changes systemd template unit-file environment variable for `DOCKER_IMAGE_PACKAGE_PATH` now defaults to the path `/var/opt/scmi/packages` instead of `/var/services-packages` however this can be reverted back using the `scmi` option `--env='DOCKER_IMAGE_PACKAGE_PATH="/var/services-packages"'` if necessary.
- Replaces `HTTPD` with `APACHE_MPM`; instead of needing to supply the path to the correct binary `APACHE_MPM` takes the Apache MPM name (i.e. `prefork` or `worker`).
- Replaces `SERVICE_UID` with `APACHE_HEADER_X_SERVICE_UID`.
- Default to using the `{{HOSTNAME}}` placeholder for the value of `APACHE_HEADER_X_SERVICE_UID`.
- Adds the `/usr/sbin/httpd-wrapper` script to make the wrapper more robust and simpler to maintain that the one-liner that was added directly using the supervisord program command.
- Adds Lockfile handling into the `/usr/sbin/httpd-bootstrap` script making it more robust and simpler to maintain.
- Adds a minor correction to a couple of the README `scmi` examples.
- Reviewed quoting of environment variables used in Apache include templates and in the bootstrap script.
- To be consistent with other `jdeathe/centos-ssh` based containers the default group used in the docker name has been changed to `pool-1` from `app-1`.
- Adds a niceness value of 10 to the httpd process in the httpd-wrapper script.
- Stops header X-Service-UID being set if `APACHE_HEADER_X_SERVICE_UID` is empty.
- Adds support for defining `APACHE_CUSTOM_LOG_LOCATION` and `APACHE_ERROR_LOG_LOCATION` paths that are relative to `APACHE_CONTENT_ROOT`. This allows for a simplified configuration.
- Prevents `scmi` installer publishing port 443 if `APACHE_MOD_SSL_ENABLED` is false.
- Adds a fix for the default value of `APACHE_HEADER_X_SERVICE_UID` when using `scmi`.
- Adds method to prevent exposed ports being published when installing using the embedded `scmi` installation method or the Makefile's create/run template. e.g. To prevent port `8443` getting published set the value of the environment variable `DOCKER_PORT_MAP_TCP_8443` to `NULL`
- Disables publishing port `8443` by default in scmi/make/systemd install templates.

### 1.6.0 - 2016-09-10

- Updates source tag to [1.6.1](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.6.1).
- Relocates VirtualHost configuration out of app package and into the container package.
- Adds simplified php-wrapper script now that configuration is handled by the php.d/\*ini scan directory includes.
- Adds restructured httpd configuration. Replaced the single template VirtualHost that was used to generate an SSL copy using the bootstrap script with 2 basic VirtualHost definitions. The majority of configuration is now pulled in from the scan directory `/etc/services-config/httpd/conf.d/*.conf` where core container configuration is prefixed with `00-`. App package configuration (`/var/www/app/etc/httpd/conf.d/*.conf`) files are added to this directory as part of the container build and prefixed with `50-` to indicate their source and influence load order.
- Adds the PHP Info script into the demo app package the source instead of generating it as part of the container build.
- Adds an increased MaxKeepAliveRequests value of 200 from the default 100.
- Removes some unused configuration scripts.
- Fixes an issue with the php-wrapper script not loading in the configuration environment variables from `/etc/httpd-bootstrap.conf`.
- Adds minor improvement to the demo app's index.php to prevent errors if either the PHP Info or  APC Info scripts are unavailable.
- The placeholder `{{HOSTNAME}}` will be replaced with the system (container) hostname when used in the value of the environment variable `SERVICE_UID`.
- Adds default of `expose_php = Off` even if the user configuration is not loaded.
- Adds `PACKAGE_PATH` environment variable to the bootstrap.
- Loading of app PHP configuration is now carried out in the bootstrap before starting `httpd` (Apache) and not as an image build time step. This is necessary to allow the environment variables to be replaced before being loaded by the fcgid php-wrapper script where the environment is cleared down.
- Adds loading of Apache app package configuration files into the bootstrap.
- Adds enable/disable of the SSL VirtualHost configuration into the bootstrap.
- Removes configuration files now pulled in from the app package's configuration.
- Adds fix for incorrect binary defined in the latest systemd template unit-file and in the makefile environment definition.

### 1.5.0 - 2016-09-04

- Updates source tag to [1.5.0](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.5.0). (i.e. Updates CentOS to 6.8).
- Adds `APACHE_OPERATING_MODE` to the systemd run command.
- Disables the default Apache DocumentRoot `/var/www/html`.
- Disables the `TRACE` method in the VirtualHost configuration.
- Updates examples in README.
- Updates SSL configuration to use 2048 bit key size to reduce CPU usage.
- Enables `SSLSessionCache` in the VirtualHost configuration.
- Updates SSL configuration to use Mozilla recommended cipher suites and order.
- Maintenance: Use single a line ENV to set all environment variables.
- Fixes an issue with log paths being incorrect due to `APACHE_CONTENT_ROOT` being undefined.
- Removes use of "AllowOverride All" in the VirtualHost configuration when no .htaccess exists in the DocumentRoot path. This would otherwise log the following error: "(13)Permission denied: /var/www/app/public_html/.htaccess pcfg_openfile: unable to check htaccess file, ensure it is readable"
- Adds Makefile to replace build.sh and run.sh
- Updates systemd template unit-files.
- Updates and relocates bootstrap script.
- Changes supervisord configuration and adds improvements to bootstrap reliability.


### 1.4.5 - 2016-04-27

- Updates source tag to [1.4.5](https://github.com/jdeathe/centos-ssh-apache-php/releases/tag/1.4.5).
- Removes files that are available in the upstream repository and not used by this `Dockerfile`.
  - Note: the [php-wrapper](https://github.com/jdeathe/centos-ssh-apache-php/blob/1.4.5/var/www/app/bin/php-wrapper) script is now maintained in the upstream source.
  - Updates `README.md` to reflect the files being available in the upstream repository.

### 1.4.4 - 2016-03-11

- Deprecates `APACHE_SUEXEC_USER_GROUP` now that `APACHE_RUN_USER` and `APACHE_RUN_GROUP` are available.
- Removes redundant build steps.
- Adds revised installation / configuration for `mod_fcgid` and erase unused `php` package.
- Sort the Apache modules in log output.
- Locate the fcgid `php-wrapper` script within the package directory.

### 1.4.3 - 2016-03-08

- Updates source tag to 1.4.3.
- Adds syntax and readability update to the php-wrapper.

### 1.4.2 - 2016-01-27

- Updates source tag to 1.4.2.
- Revised method + instructions on data volume usage.
- Improved systemd definition file and installation script.

### 1.4.1 - 2016-01-26

- Updates source tag to 1.4.1.
- Adds `HTTPD` environment variable to allow operator to switch between `httpd` (Prefork) and `httpd.worker` (Worker) Apache MPM.
- Adds feature to populate the container's /etc/hosts with `APACHE_SERVER_NAME` and `APACHE_SERVER_ALIAS` values.
- Changes the HTTP and HTTPS configuration includes and comment/uncomment entire block for the SSL configuration instead of targeting each line. _NOTE_ If you are using an existing vhost.conf and want to use the mod_ssl feature of the container instead of terminating the SSL upstream then you should update the mod_ssl configuration to the following (with the '#' at the beginning of the line):

  ```
  #        <IfModule mod_ssl.c>
  #                SSLEngine on
  #                SSLOptions +StrictRequire
  #                SSLProtocol -all +TLSv1
  #                SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM
  #                SSLCertificateFile /etc/pki/tls/certs/localhost.crt
  #                SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
  #                #SSLCACertificateFile /etc/pki/tls/certs/ca-bundle.crt
  #        </IfModule>
  ```
- Adds function to set Apache's main ServerName to suppress startup message.
- Changes the ExtendedStatus directive to to Off by default and adds `APACHE_EXTENDED_STATUS_ENABLED` to allow it to be enabled by the operator.

### 1.4.0 - 2016-01-16

- Updates CentOS to 6.7.

### 1.3.1 - 2016-01-16

- Updates upstream image to centos-6-1.3.1 tag.
- Updates the systemd definition file and installer script. Now using etcd2.
- Adds `rpm --rebuilddb` before `yum install` to resolve checksum issues that prevented build completion.
- Adds feature to apply config via environment variables + documentation updated with example use cases.
- Adds Apache module `reqtimeout_module`.

### 1.3.0 - 2015-10-31

- Changes the image to build from a specified source tag instead of branch.
- Changes the image build to specify package versions, add `versionlock` package and lock packages.
- Changes the location of the SSH configuration file to a subdirectory to be more consistent.
- Adds support for running and building on OSX Docker hosts (i.e boot2docker).

### 1.2.1 - 2015-05-25

- Fixes the systemd service file to reference the correct tag version.
- Fixes spelling errors in the README.

### 1.2.0 - 2015-05-04

- Updates CentOS to 6.6.
- Adds MIT License.

### 1.0.1 - 2014-08-29

- Fixes errors during startup of Apache due to missing `fcgid.conf` configuration file.

### 1.0.0 - 2014-08-27

- Initial release