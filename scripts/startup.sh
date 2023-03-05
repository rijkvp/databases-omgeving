#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

./scripts/start_apache.sh > /dev/null
./scripts/start_mysql.sh > /dev/null

LOCKFILE=".imported.lock"
if test -f "$LOCKFILE"; then
    echo "Databases zijn al geïmporteerd!"
else
    echo "Databases worden geïmporteerd.. Dit kan even duren.."
    start=`date +%s`
    ./scripts/import_dbs.sh > /dev/null
    end=`date +%s`
    runtime=$( echo "$end - $start" | bc -l )
    echo "Databases geïmporteerd in $runtime seconden."
    touch $LOCKFILE
fi

echo "\nOpen ${bold}http://localhost:8001${normal} voor het lesmateriaal en de websites."