#!/bin/bash

#All paths relative to scripts directory

#Primary 2nd Level Domain (no www)
  domain='foolserran.de';
#Paths to environments
  stagePath='/var/www/vhosts/stage.${domain}';
  releasePath='/var/www/vhosts/release.${domain}';
  prodPath='/var/www/vhosts/www.${domain}';
#WordPress Core Path
  WPPath=../public/wpcr
#DB Destination Path
  backup_path="../db/archive"
#DB Latest Version Path
  latest_path="../db/latest"
#This Environment Stub
  environment=xx-local; #Ex. jf-local (w/your initials), stage, or prod
#MySQL Credentials
  user='';
  password='';
  host='';
  db_name='';
