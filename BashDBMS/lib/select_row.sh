#!/bin/bash
source ./lib/validation.sh

DB_PATH="./databases/$db_name"

echo "--- Select from Table in $db_name ---"
# List tables using your standard logic
ls "$DB_PATH"/*.table 2>/dev/null | xargs -n 1 basename | sed 's/\.table//'
echo "------------------------------------"

read -p "Enter Table Name: " table_name
table_file="$DB_PATH/${table_name}.data"

if [ ! -f "$table_file" ]; then
    echo "Error: Table '$table_name' does not exist."
    return 1
fi

echo "1) Select All"
echo "2) Select by ID (Primary Key)"
read -p "Choose option: " choice

case $choice in
    1)
        cat "$table_file"
        ;;
    2)
        read -p "Enter ID to search: " pk
        # Grep exactly the start of the line for the PK
        result=$(grep -w "^$pk" "$table_file")
        if [ -n "$result" ]; then
            echo "Result: $result"
        else
            echo "No record found with ID $pk."
        fi
        ;;
    *) echo "Invalid option" ;;
esac