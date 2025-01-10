#!/usr/bin/env bash

output_str=$(upower --dump | grep -E "(model|percentage)")
#notify-send "$output"

SAVEIFS=$IFS   # Save current IFS (Internal Field Separator)
IFS=$'\n'      # Change IFS to newline char
output_lines=($output_str) # split the `names` string into an array by the same name
IFS=$SAVEIFS   # Restore original IFS

for element in "${output_lines[@]}"
do
    echo "$element"
done
