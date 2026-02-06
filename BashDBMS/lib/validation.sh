#!/bin/bash

is_valid_name(){
  [[ "$1" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]
}




is_string(){
  [[ -n "$1" ]]
}


is_int(){
 [[ "$1" =~ ^[0-9]+$ ]]
}





is_pk_unique(){
  # Use <<< to pass the string into cut
  local pk=$(cut -d: -f1 <<< "$1") 
  local table_file="$2"

  # If the data file doesn't exist yet, the PK is unique by default
  [[ ! -f "$table_file" ]] && return 0

  # Search for the PK in the first column of the file
  # -q: quiet (don't print)
  # -x: match the whole line exactly
  ! cut -d: -f1 "$table_file" | grep -qx "$pk"
}



valid_value_count() {
  local row="$1"
  local meta_file="$2"

  # 1. Count only lines that are NOT empty in the meta file
  local table_count
  table_count=$(grep -c '[^[:space:]]' "$meta_file")

  # 2. Count values in the input row
  local value_count
  value_count=$(awk -F: '{print NF}' <<< "$row")

  # Debugging info (optional, helps you see the counts)
  # echo "DEBUG: Table expects $table_count columns, Row has $value_count values."

  [[ "$table_count" -eq "$value_count" ]]
}


validate_row_datatypes() {
  local row="$1"
  local meta_file="$2"

  IFS=':' read -ra values <<< "$row"
  local index=0

  # Check if file exists to prevent loop skip
  if [[ ! -f "$meta_file" ]]; then
      echo "Error: Meta file $meta_file not found."
      return 1
  fi

  while IFS=':' read -r col_name col_type pk extra; do
    # 1. STRIP HIDDEN WINDOWS CHARACTERS (The "Magic" Fix)
    col_name=$(echo "$col_name" | tr -d '\r')
    col_type=$(echo "$col_type" | tr -d '\r')
    pk=$(echo "$pk" | tr -d '\r')
	
    value="${values[$index]}"
	
    if [[ -z "$value" ]]; then
      echo "DEBUG: No value for $col_name — stopping"
      break
    fi

    case "$col_type" in
      int)
        echo "VALIDATING $value AS INT"
        if is_int "$value"; then
          echo "VALIDATION PASSED (int)"
        else
          echo "VALIDATION FAILED (int)"
          return 1
        fi
        ;;
      string)
        echo "VALIDATING $value AS STRING"
        if is_string "$value"; then
          echo "VALIDATION PASSED (string)"
        else
          echo "VALIDATION FAILED (string)"
          return 1
        fi
        ;;
      *)
        # This will no longer say 'int:pk' because 'extra' caught the leftovers
        echo "CASE FAILED → unknown type '$col_type' for value '$value'"
        return 1
        ;;
    esac

    ((index++))
  done < "$meta_file"

  return 0
}











: <<'NAMING_CONVENTIONS'
====================================================
Naming Conventions for DBMS Identifiers
====================================================

The following naming rules apply to:
- Database names
- Table names
- Column names
- Field identifiers
- Any user-defined identifier in the DBMS

Rules:
1. Names must start with:
   - a letter (a–z or A–Z)
   - OR an underscore (_)

2. Names may contain (after the first character):
   - letters (a–z, A–Z)
   - numbers (0–9)
   - underscore (_)
   - dash (-)

3. Names must NOT:
   - start with a number
   - start with a dash (-)
   - contain spaces
   - contain special characters (@, #, $, %, ., etc.)

4. Names are CASE-SENSITIVE
   - "Users" and "users" are treated as different identifiers

Regex Used for Validation:
   ^[a-zA-Z_][a-zA-Z0-9_-]*$

Explanation:
- ^                → enforce matching from start of the string
- [a-zA-Z_]        → first character must be a letter or underscore
- [a-zA-Z0-9_-]*   → remaining characters may include letters, digits,
                     underscore, or dash
- $                → enforce matching until the end of the string

Rationale:
- Ensures safe file and directory names
- Prevents ambiguous or invalid identifiers
- Simplifies parsing and validation logic
- Aligns closely with variable naming rules

====================================================
NAMING_CONVENTIONS





: << 'HOW TO_USE'
======================
is_pk_unique pk table => checks if PK (first arg) unique in table (second arg)

if is_pk_unique "$id" "$data_file"; then
  echo "PK is unique → insert allowed"
else
  echo "PK already exists → insert blocked"
fi
======================
HOW TO_USE







:
: << 'HOW TO_USE'
======================
if valid_value_count "$row" "$meta_file"; then
  echo "Value count matches schema"
else
  echo "Value count mismatch"
fi
======================
HOW TO_USE








: <<'USAGE'
Usage:
validate_row_datatypes row meta_file

Example:
validate_row_datatypes "$row" "$meta_file"
USAGE









