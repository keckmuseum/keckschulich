#!/bin/bash

#Get config
. scripts-config.sh

#Warn about being run from prod server
read -p "${environment} sync-db: This script is meant to be run from the production server. Continue? [y/n]
" cont;
if [ $cont == y ]; then

  #Backup All Environment DBs
  echo "${environment} sync-db: Backing DBs";
  . backup-server-environtment-dbs.sh

  # Ask which environtment to sync from
  read -p "${environment} sync-db: Sync from? [prod/release/stage]
  " from;
  if [ $from == prod ]; then
    envPath=$prodPath;
    stub='prod';
  fi
  if [ $from == release ]; then
    envPath=$releasePath;
    stub='release';
  fi
  if [ $from == stage ]; then
    envPath=$stagePath;
    stub='stage';
  fi
  mysql -u$user -p$password -h $host $db_name < $envPath/$latest_path/$db_name-$stub-latest.sql

fi
