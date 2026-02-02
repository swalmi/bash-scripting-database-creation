#!/bin/bash

read -p "Enter Database Name to Drop: " db_name

if [[ -d "./databases/$db_name" ]]; then
    rm -r "./databases/$db_name"
    echo "Database deleted."
else
    echo "Database not found."
fi
