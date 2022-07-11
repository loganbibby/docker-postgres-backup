#!/usr/bin/env bash

if [[ -z "${POSTGRES_DB}" ]]; then
	DBNAME="$POSTGRES_DB"
else
	DBNAME="$POSTGRES_USER"
fi

FILENAME="$DBNAME-$(date +%Y%m%d%H%M%S).bkup"

cd /backups

echo "Backing up $DBNAME..."
pg_dump -U $POSTGRES_USER -F c -f $FILENAME $DBNAME

echo "Moving backup to $AWS_S3_BUCKET: $FILENAME"
aws s3 mv $FILENAME s3://$AWS_S3_BUCKET

echo "Backup complete"
