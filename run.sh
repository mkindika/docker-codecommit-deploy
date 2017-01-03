#!/bin/sh
set -euo pipefail
SHA1=

echo "[i] clean working directory"
rm -rf *

echo "[i] do shallow clone of ${REPO}"
git clone "${REPO}" . --depth=1 --quiet

while true
do
  if [ "${SHA1}" != "$(git ls-remote --exit-code origin master | awk '{print $1;}')" ]; then
    echo "[i] update detected, fetching"
    git fetch --depth=1 --quiet
    echo "[i] fetched $(git log --pretty=oneline --abbrev-commit --max-count=1 origin/master)"
    echo "[i] reset hard"
    git reset origin/master --hard --quiet
    echo "[i] clean"
    git clean -xdf --quiet
    echo "[i] docker-compose pull"
    docker-compose pull
    echo "[i] docker-compose build"
    docker-compose build --force-rm
    echo "[i] docker-compose up"
    docker-compose up -d --remove-orphans
    echo "[i] done"
    SHA1="$(git rev-parse HEAD)"
  fi
  if [ "${INTERVAL}" = "-1" ]; then  exit 0; fi
  sleep ${INTERVAL}
done
