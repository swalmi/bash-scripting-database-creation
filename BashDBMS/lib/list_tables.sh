#!/bin/bash

[[ ! -d "$CURRENT_DB" ]] && zenity --error --text="No database selected." && return

list=()

for table in "$CURRENT_DB"/*.table; do
    [[ -f "$table" ]] || continue
    table_name=$(basename "$table" .table)
    col_count=$(grep -cv '^$' "$table")
    list+=("$table_name" "$col_count")
done

if [[ ${#list[@]} -eq 0 ]]; then
    zenity --info --text="No tables available."
    return
fi

zenity --list \
    --title="Tables" \
    --column="Table Name" \
    --column="Columns" \
    "${list[@]}"
