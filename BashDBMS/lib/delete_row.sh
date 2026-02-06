#!/bin/bash
source ./lib/validation.sh

DB_PATH="./databases/$db_name"

read -p "Enter Table Name to delete from: " table_name
table_file="$DB_PATH/${table_name}.data"

if [ ! -f "$table_file" ]; then
    echo "Error: Table not found."
    return 1
fi

read -p "Enter Primary Key (ID) to delete: " pk

# Check if ID exists first
if grep -qw "^$pk" "$table_file"; then
    # -v keeps everything EXCEPT the matching PK
    grep -vw "^$pk" "$table_file" > "${table_file}.tmp" && mv "${table_file}.tmp" "$table_file"
    echo "Record $pk deleted successfully."
else
    echo "Error: ID $pk not found."
fi