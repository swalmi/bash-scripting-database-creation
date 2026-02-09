#!/bin/bash

function table_menu() {
    while true
    do
        choice=$(zenity --list \
            --title="Table Menu" \
            --column="Choose Option" \
            "Create Table" \
            "List Tables" \
            "Drop Table" \
            "Insert Into Table" \
            "Select From Table" \
            "Delete From Table" \
            "Update Table" \
            "Back")

        case "$choice" in
            "Create Table") source ./lib/create_table.sh ;;
            "List Tables") source ./lib/list_tables.sh ;;
            "Drop Table") source ./lib/drop_table.sh ;;
            "Insert Into Table") source ./lib/insert_row.sh ;;
            "Select From Table") source ./lib/select_row.sh ;;
            "Delete From Table") source ./lib/delete_row.sh ;;
            "Update Table") source ./lib/update_row.sh ;;
            "Back"|"" ) break ;;
        esac
    done
}
