#!/bin/bash

function db_menu() {
    while true
    do
        echo "========== DBMS =========="
        echo "1) Create Database"
        echo "2) List Databases"
        echo "3) Connect To Database"
        echo "4) Drop Database"
        echo "5) Exit"
        read -p "Choose option: " choice

        case $choice in
            1) source ./lib/create_db.sh ;;
            2) source ./lib/list_db.sh ;;
            3) source ./lib/connect_db.sh ;;
            4) source ./lib/drop_db.sh ;;
            5) exit ;;
            *) echo "Invalid choice" ;;
        esac
    done
}
