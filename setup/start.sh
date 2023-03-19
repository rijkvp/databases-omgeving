#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

./setup/start-apache.sh
./setup/start-mysql.sh

LOCKFILE=".imported.lock"
if ! test -f "$LOCKFILE"; then
    echo "Databases worden geïmporteerd.."
    start=`date +%s`
    ./setup/import-dbs.sh
    echo "Databases geïmporteerd."
    touch $LOCKFILE
fi

echo "Open ${bold}http://localhost:80${normal} om lesmateriaal/websites te bekijken"
