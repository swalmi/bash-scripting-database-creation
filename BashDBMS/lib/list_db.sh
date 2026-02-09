#!/bin/bash

DB_DIR="./databases"
list=()

for db in "$DB_DIR"/*; do
    [[ -d "$db" ]] || continue
    list+=("$(basename "$db")")
done

if [[ ${#list[@]} -eq 0 ]]; then
    zenity --info --text="No databases found."
    return
fi

zenity --list \
    --title="Available Databases" \
    --column="Database Name" \
    "${list[@]}"
