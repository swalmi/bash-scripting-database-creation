#!/bin/bash

read -p "Enter Database Name: " db_name

if [[ -d "./databases/$db_name" ]]; then
    echo "Database already exists!"
else
    mkdir "./databases/$db_name"
    echo "Database '$db_name' created successfully."
fi
