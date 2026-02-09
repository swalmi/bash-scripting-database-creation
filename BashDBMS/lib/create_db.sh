#!/bin/bash
source ./lib/validation.sh

db_name=$(zenity --entry \
    --title="Create Database" \
    --text="Enter Database Name:")

[[ -z "$db_name" ]] && return

if ! is_valid_name "$db_name"; then
    zenity --error --text="Invalid database name."
    return
fi

if [[ -d "./databases/$db_name" ]]; then
    zenity --error --text="Database already exists!"
else
    mkdir "./databases/$db_name"
    zenity --info --text="Database '$db_name' created successfully."
fi
