#!/usr/bin/env bash

FILENAME=$1

if [[ -z "${POSTGRES_DB}" ]]; then
	DBNAME="$POSTGRES_DB"
else
	DBNAME="$POSTGRES_USER"
fi

cd /backups

echo "Copying backup from $AWS_S3_BUCKET: $FILENAME"
aws s3 cp s3://$AWS_S3_BUCKET/$FILENAME $FILENAME

echo "Restoring to $DBNAME"
pg_restore -U $POSTGRES_USER -d $DBNAME $FILENAME

echo "Restoration complete"
