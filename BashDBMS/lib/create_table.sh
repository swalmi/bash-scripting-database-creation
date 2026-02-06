#!/bin/bash

read -p "Enter Table Name: " table_name

table_file="$CURRENT_DB/$table_name.table"

if [[ -f $table_file ]]; then
    echo "Table already exists!"
    return
fi

read -p "Enter number of columns: " col_num

schema=""
pk_set=0

for (( i=1; i<=col_num; i++ ))
do
    read -p "Enter column $i name: " col_name

    while true
    do
        read -p "Enter datatype for $col_name (int/string): " col_type
        if [[ $col_type == "int" || $col_type == "string" ]]; then
            break
        else
            echo "Invalid datatype. Choose int or string."
        fi
    done

    if [[ $pk_set -eq 0 ]]; then
        read -p "Is this column Primary Key? (y/n): " is_pk
        if [[ $is_pk == "y" || $is_pk == "Y" ]]; then
            schema+="$col_name:$col_type:PK"$'\n'
            pk_set=1
            continue
        fi
    fi

    schema+="$col_name:$col_type"$'\n'
done

if [[ $pk_set -eq 0 ]]; then
    echo "You must select a Primary Key!"
    return
fi

# Remove last |
schema=${schema%|}

echo "$schema" > "$table_file"

echo "Table '$table_name' created successfully."
