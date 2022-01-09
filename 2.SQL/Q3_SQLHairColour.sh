#!/bin/bash
# Part 1.2 Q3
# Script that selects the maximum height, calls it 'Max Height' & hair colour
# Groups the result by hair colour and orders by hair colour ascending 

mysql << EOF
use People_Info;

Select MAX(Height) as 'Max Height',Hair_Colour from Detailed_Description Group by Hair_Colour Order by Hair_Colour ASC;

EOF
