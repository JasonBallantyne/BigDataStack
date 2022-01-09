#!/bin/bash

# Part 1.1
# This script deals with Q1 & Q2

touch cleaned.csv

while read line
do
	echo "$line" | sed 's/#]//' |  sed 's/-/,/g' | sed ':a;s/^\(\([^"]*,\?\|"[^",]*",\?\)*"[^",]*\),/\1 /;ta' | tr -d '"'
done < bashdm.csv > cleaned.csv
