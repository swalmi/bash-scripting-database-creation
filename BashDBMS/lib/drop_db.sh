#!/bin/bash

db_name=$(zenity --entry \
    --title="Drop Database" \
    --text="Enter Database Name to Drop:")

[[ -z "$db_name" ]] && return

if [[ -d "./databases/$db_name" ]]; then
    zenity --question --text="Are you sure you want to delete '$db_name'?"
    if [[ $? -eq 0 ]]; then
        rm -r "./databases/$db_name"
        zenity --info --text="Database deleted."
    fi
else
    zenity --error --text="Database not found."
fi
