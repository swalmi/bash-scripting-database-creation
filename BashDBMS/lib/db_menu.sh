#!/bin/bash

function db_menu() {
    while true
    do
        choice=$(zenity --list \
            --title="Bash DBMS" \
            --column="Choose Option" \
            "Create Database" \
            "List Databases" \
            "Connect To Database" \
            "Drop Database" \
            "Exit")

        case "$choice" in
            "Create Database") source ./lib/create_db.sh ;;
            "List Databases") source ./lib/list_db.sh ;;
            "Connect To Database") source ./lib/connect_db.sh ;;
            "Drop Database") source ./lib/drop_db.sh ;;
            "Exit"|"" ) exit ;;
        esac
    done
}
