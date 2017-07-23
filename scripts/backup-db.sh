#!/bin/bash

dbPath=$1 #root path of db dir
dbSlug=$2 #slug used while nameing

#Date
  date=$(date +"%Y-%m-%d-%H-%M-%S")
#Set default file permissions
  umask 177
#Delete files in Latest Path
  #find $latest_path/* -exec rm {} \;

dbTarget=$dbPath/archive/$dbSlug-$WORDPRESS_ENV-$date.sql

if [ ! -d "${dbPath}" ]; then
  mkdir $dbPath
  if [ ! -d "${dbPath}/archive" ]; then
    mkdir $dbPath/archive
  fi
  if [ ! -d "${dbPath}/latest" ]; then
    mkdir $dbPath/latest
  fi
fi

# Dump
mysqldump -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -h$WORDPRESS_DB_HOST $WORDPRESS_DB_NAME > $dbTarget

if [ -f $dbTarget ]; then
  cp $dbTarget $dbPath/latest/$dbSlug-$WORDPRESS_ENV-latest.sql
else
  echo $0: error during mysqldump
  exit 1
fi


echo "${WORDPRESS_ENV} backup-db: DB backup completed.";
#Delete files older than 30 days
 find $dbPath/archive/* -mtime +30 -exec rm {} \;
