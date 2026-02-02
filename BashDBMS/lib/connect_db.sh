#!/bin/bash

read -p "Enter Database Name: " db_name

if [[ -d "./databases/$db_name" ]]; then
    export CURRENT_DB="./databases/$db_name"
    echo "Connected to $db_name"

    source ./lib/table_menu.sh
    table_menu    
else
    echo "Database not found."
fi

