FROM alpine:latest
LABEL maintainer="Johannes Schickling <schickling.j@gmail.com>"

RUN apk update && \
    apk add postgresql-client python3 py3-pip && \
    rm -rf /var/cache/apk/*
RUN pip install awscli

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_BACKUP_ALL false
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_PREFIX 'backup'
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_ENDPOINT **None**
ENV S3_IAMROLE false
ENV S3_S3V4 no
ENV SCHEDULE **None**
ENV ENCRYPTION_PASSWORD **None**

ADD run.sh run.sh
ADD backup.sh backup.sh

ENTRYPOINT []
CMD ["sh", "run.sh"]
