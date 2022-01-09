#!/bin/bash

# Part 1.1
# This script deals with Q4


awk -F"&|," 'FNR==NR{

if(NR>1) a[$2]=$3
next}

{if(FNR==2) next

 $4 = ($4 in a ? a[$4] : "Country") }
1' OFS=, countries.csv removed_columns.csv > fully_cleaned.csv