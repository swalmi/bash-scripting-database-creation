#!/bin/bash
source ./lib/validation.sh

table_name=$(zenity --entry \
    --title="Create Table" \
    --text="Enter Table Name:")

[[ -z "$table_name" ]] && return

if ! is_valid_name "$table_name"; then
    zenity --error --text="Invalid table name."
    return
fi

table_file="$CURRENT_DB/$table_name.table"

if [[ -f "$table_file" ]]; then
    zenity --error --text="Table already exists!"
    return
fi

col_num=$(zenity --entry \
    --title="Create Table" \
    --text="Enter number of columns:")

[[ -z "$col_num" || ! "$col_num" =~ ^[0-9]+$ ]] && return

schema=""
pk_set=0

for (( i=1; i<=col_num; i++ ))
do
    col_name=$(zenity --entry \
        --title="Column $i" \
        --text="Enter column name:")

    [[ -z "$col_name" ]] && ((i--)) && continue

    if ! is_valid_name "$col_name"; then
        zenity --error --text="Invalid column name."
        ((i--))
        continue
    fi

    col_type=$(zenity --list \
        --title="Datatype" \
        --column="Choose datatype" \
        "int" "string")

    [[ -z "$col_type" ]] && ((i--)) && continue

    if [[ $pk_set -eq 0 ]]; then
        zenity --question --text="Make '$col_name' Primary Key?"
        if [[ $? -eq 0 ]]; then
            schema+="$col_name:$col_type:PK"$'\n'
            pk_set=1
            continue
        fi
    fi

    schema+="$col_name:$col_type"$'\n'
done

if [[ $pk_set -eq 0 ]]; then
    zenity --error --text="You must select a Primary Key!"
    return
fi

echo "$schema" > "$table_file"
zenity --info --text="Table '$table_name' created successfully."
