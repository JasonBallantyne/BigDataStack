#!/bin/bash
# Part 1.2 Q1
# Script that creates a database,a table and inserts our cleaned csv "fully_cleaned.csv" into MySQL


mysql << EOF
USE mysql;
CREATE DATABASE IF NOT EXISTS People_Info;
USE People_Info;
CREATE TABLE IF NOT EXISTS Detailed_Description(INDEX_A SMALLINT NOT NULL, Name VARCHAR(255) NOT NULL,Age SMALLINT NOT NULL,Country VARCHAR(255) NOT NULL,Height SMALLINT NOT NULL,Hair_Colour VARCHAR(255) NOT NULL);
EOF

input="fully_cleaned.csv"
sed 1d $input | while IFS=, read -r INDEX_A Name Age Country Height Hair_Colour

do
mysql -D "People_Info" -e "insert into Detailed_Description values('$INDEX_A','$Name','$Age','$Country','$Height','$Hair_Colour')"
done


