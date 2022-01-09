#!/bin/bash
# Part 1.2 Q2
# Script that selects the country & average height, groups by country and ordered by average height ascending

mysql << EOF
use People_Info;
Select Country, avg(Height) as AverageHeight from Detailed_Description Group by Country Order by AverageHeight ASC;

EOF
