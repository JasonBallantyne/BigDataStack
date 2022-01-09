#!/bin/bash
# Part 1.2 Q1
# Script that inserts our cleaned csv "fully_cleaned.csv" into MongoDB


input="fully_cleaned.csv"

sed 1d $input | while IFS="," read -r -a var

do

mongo PeopleData --eval 'db.MongoDetail.insert({INDEX: "'"${var[0]}"'",Name: "'"${var[1]}"'", Age: "'"${var[2]}"'", Country: "'"${var[3]}"'", Height: "'"${var[4]}"'", Hair_Colour: "'"${var[5]}"'"})'

done
