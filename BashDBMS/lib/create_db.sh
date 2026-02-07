#!/bin/bash

source ./lib/validation.sh

read -p "Enter Database Name: " db_name

if ! is_valid_name "$db_name"; then
    echo "Invalid database name."
    return
fi

if [[ -d "./databases/$db_name" ]]; then
    echo "Database already exists!"
else
    mkdir "./databases/$db_name"
    echo "Database '$db_name' created successfully."
fi
