# postgres-backup-s3

Backup PostgresSQL to S3 (supports periodic backups)

## Usage

Docker:
```sh
$ docker run -e S3_ACCESS_KEY_ID=key -e S3_SECRET_ACCESS_KEY=secret -e S3_BUCKET=my-bucket -e S3_PREFIX=backup -e POSTGRES_DATABASE=dbname -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_HOST=localhost schickling/postgres-backup-s3
```

Docker Compose:
```yaml
version: '3.3'
services:
  backup-pqsql:
    image: mrcs2000/postgres-backup-s3:latest
    environment:
      - S3_ENDPOINT=${S3_ENDPOINT}
      - S3_ACCESS_KEY_ID=${S3_ACCESS_KEY_ID}
      - S3_SECRET_ACCESS_KEY=${S3_SECRET_ACCESS_KEY}
      - S3_BUCKET=${S3_BUCKET}
      - S3_PREFIX=${S3_PREFIX}
      - POSTGRES_HOST=${POSTGRES_HOST}
      - POSTGRES_DATABASE=${POSTGRES_DATABASE}
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - SCHEDULE=${SCHEDULE}
    networks:
        backupdbs3:
networks:
  backupdbs3:
    external: true
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

### Backup All Databases

You can backup all available databases by setting `POSTGRES_BACKUP_ALL="true"`.

Single archive with the name `all_<timestamp>.sql.gz` will be uploaded to S3

### Endpoints for S3

An Endpoint is the URL of the entry point for an AWS web service or S3 Compitable Storage Provider.

You can specify an alternate endpoint by setting `S3_ENDPOINT` environment variable like `protocol://endpoint`

**Note:** S3 Compitable Storage Provider requires `S3_ENDPOINT` environment variable

### Encryption

You can additionally set the `ENCRYPTION_PASSWORD` environment variable like `-e ENCRYPTION_PASSWORD="superstrongpassword"` to encrypt the backup. It can be decrypted using `openssl aes-256-cbc -d -in backup.sql.gz.enc -out backup.sql.gz`.
