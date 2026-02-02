#!/bin/bash

DB_PATH="./databases"
mkdir -p "$DB_PATH"

source ./lib/db_menu.sh

db_menu
