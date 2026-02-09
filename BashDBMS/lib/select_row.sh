#!/bin/bash
source ./lib/validation.sh

DB_PATH="./databases/$db_name"

echo "--- Select from Table in $db_name ---"
ls "$DB_PATH"/*.table 2>/dev/null | xargs -n 1 basename | sed 's/\.table//'
echo "------------------------------------"

read -p "Enter Table Name: " table_name
table_file="$DB_PATH/${table_name}.data"
table_schema="$DB_PATH/${table_name}.table"

if [ ! -f "$table_file" ]; then
    echo "Error: Table '$table_name' does not exist."
    return 1
fi

echo "1) Select All"
echo "2) Select by ID (Primary Key)"
read -p "Choose option: " choice

case $choice in
    1)
        echo ""
        echo "----------------------------------------------"
        # Print ALL column names (not just first line)
        cat "$table_schema" | cut -d: -f1 | tr '\n' '\t'
        echo ""
        echo "----------------------------------------------"
        # Print data
        cat "$table_file" | tr ':' '\t'
        echo ""
        echo "----------------------------------------------"
        ;;
    2)
        read -p "Enter ID to search: " pk
        result=$(grep -w "^$pk" "$table_file")
        if [ -n "$result" ]; then
            echo ""
            echo "----------------------------------------------"
            cat "$table_schema" | cut -d: -f1 | tr '\n' '\t'
            echo ""
            echo "----------------------------------------------"
            echo "$result" | tr ':' '\t'
            echo ""
            echo "----------------------------------------------"
        else
            echo "No record found with ID $pk."
        fi
        ;;
    *) echo "Invalid option" ;;
esac