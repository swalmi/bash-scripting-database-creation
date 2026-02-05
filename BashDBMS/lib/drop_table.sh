#!/bin/bash

if [[ ! -d "$CURRENT_DB" ]]; then
    echo "No database selected."
    return
fi

source ./lib/list_tables.sh

read -p "Enter table name to drop: " table_name

table_file="$CURRENT_DB/$table_name.table"

if [[ ! -f "$table_file" ]]; then
    echo "Table not found."
    return
fi

read -p "Are you sure you want to delete table '$table_name'? (y/n): " confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then
    rm "$table_file"
    echo "Table '$table_name' deleted successfully."
else
    echo "Operation cancelled."
fi
