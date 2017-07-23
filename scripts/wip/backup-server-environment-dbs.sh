#!/bin/bash

#Get config
. scripts-config.sh


#Backup All Environment DBs
echo "${environment} backup-server-environtment-dbs: Backing up production DB";
. ${prodPath}/scripts/backup-db.sh

echo "${environment} backup-server-environtment-dbs: Backing up release DB";
. ${releasePath}/scripts/backup-db.sh

echo "${environment} backup-server-environtment-dbs: Backing up stage DB";
. ${stagePath}/scripts/backup-db.sh
