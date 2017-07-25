# WordPress Scaffold #
A Scaffold structure for WordPress (core in a subdirectory), with a sample docker-compose file, and scripts to set everything up. Based on a docker image with ubuntu 16.04 letsencrypt certbot and wp-cli.

### Install ###
* `cp docker-compose.sample.yml docker-compose.yml`
* edit docker-compose.yml
* `docker-compose up -d` or `docker-compose up` to see console output.

### What is it Doing? ###
#### Docker Compose sets up 3 containers: ####
##### db #####
mysql:5.7
* Mounts docker/conf/mysql (in case of mysql custimization), docker/conf/db_data (to persist DB)
##### wordpress #####
revoltmedia/ubuntu (ubuntu 16.04 nginx php7 box)
* Mounts docker/conf/nginx, docker/conf/php (in case of nginx or php customization)
* Mounts secrets containing salts files which shouldn't be kept in version control
* Mounts scripts which has init scripts and other tools needed.
* Mounts public containing site files
* Tunnels port 80 to 8888 on the host.
* Sets various environment variables for use in WordPress and the init scripts.
* Runs nginx
##### wordpressinit #####
runs an init bash script to check some things and do some initial setup if needed - revoltmedia/ubuntu (ubuntu 16.04 nginx php7 box)
* Mounts most of the same directories as wordpress container
* Has same environment variables as wordpress container
* Runs scripts/init.sh
** Checks if core directory exists
*** If not: creates it, downloads wp core files, and sets up permissions
** Checks if public/content directory exists
*** If not: creates it and sets up permissions
** Checks the WORDPRESS_IMPORT_DB variable
*** If set: pushes that file to the mysql db (set in docker-compose environment variables)
** Checks if the secrets/salts.php file exists
*** If not: creates a copy from secrets/salts.sample.php, then runs another script to generate the salts.
** Cron jobs: coming soon...

##### Known Issues #####
* nginx forbidden (permission issues?)
* import db option untested
* cron jobs option doesn't work yet
