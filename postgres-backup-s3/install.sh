#! /bin/sh

# exit if a command fails
set -eo pipefail

apk update

# install postgresql-client
apk add postgresql-client 

# install s3 tools
apk add python3 py3-pip
pip install awscli

# cleanup
rm -rf /var/cache/apk/*
