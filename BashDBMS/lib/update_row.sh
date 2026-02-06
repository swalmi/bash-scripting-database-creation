#!/bin/bash
source ./lib/validation.sh

DB_PATH="./databases/$db_name"

read -p "Enter Table Name to update: " table_name
table_file="$DB_PATH/${table_name}.data"
table_schema="$DB_PATH/${table_name}.table"

if [ ! -f "$table_file" ]; then
    echo "Error: Table not found."
    return 1
fi

read -p "Enter Primary Key (ID) of the row to update: " pk

# 1. Find the old record
old_row=$(grep -w "^$pk" "$table_file")

if [ -z "$old_row" ]; then
    echo "Error: Record with ID $pk not found."
    return 1
fi

echo "Current Record: $old_row"
read -p "Enter NEW row data (ID:Value:Value): " new_row

# 2. Re-Validate everything using your existing logic
if valid_value_count "$new_row" "$table_schema"; then
    if validate_row_datatypes "$new_row" "$table_schema"; then
        
        # Check if the NEW PK is either the same as the old one OR unique
        new_pk=$(echo "$new_row" | cut -d: -f1)
        if [[ "$new_pk" == "$pk" ]] || is_pk_unique "$new_row" "$table_file"; then
            
            # Use sed to replace the specific line
            sed -i "s/^$old_row$/$new_row/" "$table_file"
            echo "Record updated successfully."
        else
            echo "Error: New PK already exists in the table."
        fi
    else
        echo "Error: Data type validation failed."
    fi
else
    echo "Error: Column count mismatch."
fi