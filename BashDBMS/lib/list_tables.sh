#!/bin/bash

if [[ ! -d "$CURRENT_DB" ]]; then
    echo "No database selected."
    return
fi

tables=("$CURRENT_DB"/*.table)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo "No tables available."
    return
fi

echo
echo "Available Tables"
echo "---------------------------------------"
printf "%-3s| %-20s | %-7s\n" "No" "Table Name" "Columns"
echo "---------------------------------------"

i=1
for table in "${tables[@]}"
do
    table_name=$(basename "$table" .table)
    schema=$(head -n 1 "$table")
    col_count=$(echo "$schema" | awk -F'|' '{print NF}')

    printf "%-3s| %-20s | %-7s\n" "$i" "$table_name" "$col_count"
    ((i++))
done

echo "---------------------------------------"
echo
