#!/bin/bash

if [ $# -ne 1 ]; then
    echo $0: usage: restore-db.sh path/to/db.sql
    exit 1
fi

dbPath=$1

mysql -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -h$WORDPRESS_DB_HOST $WORDPRESS_DB_NAME < $dbPath
