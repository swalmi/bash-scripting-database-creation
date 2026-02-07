#!/bin/bash

DB_DIR="./databases"

echo
echo "Available Databases"
echo "--------------------"

i=1
for db in "$DB_DIR"/*; do
    if [[ -d "$db" ]]; then
        db_name=$(basename "$db")
        echo "$i) $db_name"
        ((i++))
    fi
done

if [[ $i -eq 1 ]]; then
    echo "No databases found."
fi

echo
