#!/bin/bash

source ./lib/validation.sh

DB_PATH="./databases/$db_name"

# 1. List Available Tables (only once at the start)
echo "--- Available Tables in $db_name ---"
if [ -d "$DB_PATH" ]; then
    files=("$DB_PATH"/*.table)
    if [ -e "${files[0]}" ]; then
        for file in "${files[@]}"; do
            basename "$file" .table
        done
    else
        echo "No tables found in this database."
        return 1
    fi
else
    echo "Error: Database directory '$db_name' not found."
    return 1
fi
echo "------------------------------------"

read -p "Enter Table Name: " table_name

table_file="$DB_PATH/${table_name}.data"
table_schema="$DB_PATH/${table_name}.table"

if [ ! -f "$table_schema" ]; then
    echo "Error: Table schema '$table_name.table' does not exist."
    return 1
fi

[ ! -f "$table_file" ] && touch "$table_file"

# 2. Define the Insertion Function
insert_row(){
    local row="$1"
    local schema="$2"
    local data_path="$3"

    if validate_row_datatypes "$row" "$schema"; then
        echo "$row" >> "$data_path"
        echo "Successfully inserted into $table_name."
    else
        echo "Error: Data validation failed."
        return 1
    fi
}

# 3. The Main Insertion Loop
while true; do
    echo ""
    echo "--- Inserting into $table_name ---"
    read -p "Enter a row to insert (or type 'exit' to return to menu): " data

    # Check if user wants to quit the loop
    if [[ "$data" == "exit" ]]; then
        break
    fi

    # Run validations
    if is_pk_unique "$data" "$table_file"; then
        if valid_value_count "$data" "$table_schema"; then
            insert_row "$data" "$table_schema" "$table_file"
        else 
            echo "Error: Values count doesn't match available columns!"
        fi
    else 
        echo "Error: Primary Key (PK) duplicated. Each entry must be unique."
    fi

    echo "------------------------------------"
done

echo "Returning to Table Menu..."