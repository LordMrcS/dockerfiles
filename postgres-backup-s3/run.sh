#! /bin/sh

set -eo pipefail
if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  sh backup.sh
else
  echo "$SCHEDULE /bin/sh /backup.sh >/proc/1/fd/1 2>/proc/1/fd/2" > /etc/crontabs/root
  exec crond -f -l 2
fi
