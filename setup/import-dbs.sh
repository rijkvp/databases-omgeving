#!/bin/sh
# Imports all databases from the database directory
mysql="mysql -h 127.0.0.1 -u user --password=password"
if [ ! -d "./databases" ]; then
    echo "No databases folder."
    exit
fi
for db_path in ./databases/*.sql;
do
    db_name=$(basename $db_path .sql)
    echo "Import $db_name"
    $mysql -e "DROP DATABASE IF EXISTS $db_name; CREATE DATABASE $db_name;"
    $mysql --init-command="SET SESSION FOREIGN_KEY_CHECKS=0;" $db_name < $db_path
done
