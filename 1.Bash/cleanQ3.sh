#!/bin/bash

# Part 1.1
# This script deals with Q3

non_unqiue_list=()
data=cleaned.csv

col_number=$(head -1 $data| sed -e 's/[^,]//g' | wc -c)

for ((i=1 ; i <= $col_number ; i++)); do
    unique_col=$(cut -f$i -d',' $data | tail -n +2 | sort | uniq -c | wc -l)
    if [[ $unique_col -eq 1 ]]; then
       non_unqiue_list+=($i)
    fi
done

IFS=\, eval 'non_unqiue_list="${non_unqiue_list[*]}"'
cut -d"," -f$non_unqiue_list --complement $data > "removed_columns.csv"