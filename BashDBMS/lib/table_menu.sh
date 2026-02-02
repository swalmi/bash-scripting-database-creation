#!/bin/bash

function table_menu() {
    while true
    do
        echo "====== Table Menu ======"
        echo "1) Create Table"
        echo "2) List Tables"
        echo "3) Drop Table"
        echo "4) Insert Into Table"
        echo "5) Select From Table"
        echo "6) Delete From Table"
        echo "7) Update Table"
        echo "8) Back"
        read -p "Choose option: " choice

        case $choice in
            1) source ./lib/create_table.sh ;;
            2) source ./lib/list_tables.sh ;;
            3) source ./lib/drop_table.sh ;;
            4) source ./lib/insert_row.sh ;;
            5) source ./lib/select_row.sh ;;
            6) source ./lib/delete_row.sh ;;
            7) source ./lib/update_row.sh ;;
            8) break ;;
            *) echo "Invalid choice" ;;
        esac
    done
}
