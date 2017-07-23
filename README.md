# WordPress Scaffold #
A Scaffold structure for WordPress (core in a subdirectory), with a sample docker-compose file, and scripts to set everything up. Based on a docker image with ubuntu 16.04 letsencrypt certbot and wp-cli.

### Install ###
* `cp docker/docker-compose.sample.yml docker/docker-compose.yml`
* edit docker/docker-compose.yml
* `docker-compose up -d`
