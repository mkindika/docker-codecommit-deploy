#!/bin/sh
set -e
SHA1=
rm -rf *
git clone --depth=1 "${REPO}" .
while true
do
  if [ "${SHA1}" != "$(git ls-remote --exit-code origin master | awk '{print $1;}')" ]; then
    git fetch --depth=1
    git reset --hard origin/master
    git clean -xdf
    docker-compose pull
    docker-compose build
    docker-compose up -d --remove-orphans
    SHA1="$(git rev-parse HEAD)"
  fi
  if [ "${INTERVAL}" = "-1" ]; then
    exit 0
  fi
  sleep ${INTERVAL}
done
