#!/bin/bash

db_name=$(zenity --entry \
    --title="Connect Database" \
    --text="Enter Database Name:")

[[ -z "$db_name" ]] && return

if [[ -d "./databases/$db_name" ]]; then
    export CURRENT_DB="./databases/$db_name"
    zenity --info --text="Connected to $db_name"

    source ./lib/table_menu.sh
    table_menu
else
    zenity --error --text="Database not found."
fi
