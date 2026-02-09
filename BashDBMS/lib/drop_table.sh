#!/bin/bash

[[ ! -d "$CURRENT_DB" ]] && zenity --error --text="No database selected." && return

tables=()
for table in "$CURRENT_DB"/*.table; do
    [[ -f "$table" ]] || continue
    tables+=("$(basename "$table" .table)")
done

[[ ${#tables[@]} -eq 0 ]] && zenity --info --text="No tables to delete." && return

table_name=$(zenity --list \
    --title="Drop Table" \
    --column="Choose Table" \
    "${tables[@]}")

[[ -z "$table_name" ]] && return

zenity --question --text="Are you sure you want to delete '$table_name'?"
if [[ $? -eq 0 ]]; then
    rm "$CURRENT_DB/$table_name.table"
    zenity --info --text="Table '$table_name' deleted successfully."
fi
