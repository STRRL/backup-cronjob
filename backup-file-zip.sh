#!/bin/bash

## Configuration
SRC_CODE=${SRC_CODE:-"/data/source"}
BACKUP_DIR=${BACKUP_DIR:-"/data/backup"}
PROJECT_NAME=${PROJECT_NAME:-"project"}
BACKUP_DAILY=true # if set to false backup will not work
BACKUP_WEEKLY=false # if set to false backup will not work
BACKUP_MONTHLY=false # if set to false backup will not work
BACKUP_RETENTION_DAILY=7
BACKUP_RETENTION_WEEKLY=3
BACKUP_RETENTION_MONTHLY=3

MONTH=`date +%d`
DAYWEEK=`date +%u`

if [[ ( $MONTH -eq 1 ) && ( $BACKUP_MONTHLY == true ) ]];
        then
        FN='monthly'
elif [[ ( $DAYWEEK -eq 7 ) && ( $BACKUP_WEEKLY == true ) ]];
        then
        FN='weekly'
elif [[ ( $DAYWEEK -lt 7 ) && ( $BACKUP_DAILY == true ) ]];
        then
        FN='daily'
fi

DATE=$FN-`date +"%Y%m%d"`


function local_only
{
	zip -r $BACKUP_DIR/$PROJECT_NAME-backup-$DATE.zip $SRC_CODE
	cd $BACKUP_DIR/
	ls -t | grep $PROJECT_NAME | grep backup | grep daily | sed -e 1,"$BACKUP_RETENTION_DAILY"d | xargs -d '\n' rm -R > /dev/null 2>&1
	ls -t | grep $PROJECT_NAME | grep backup | grep weekly | sed -e 1,"$BACKUP_RETENTION_WEEKLY"d | xargs -d '\n' rm -R > /dev/null 2>&1
	ls -t | grep $PROJECT_NAME | grep backup | grep monthly | sed -e 1,"$BACKUP_RETENTION_MONTHLY"d | xargs -d '\n' rm -R > /dev/null 2>&1
}

local_only || exit 0
