It is important to run these scripts in chronological order.
Eg.
1. cleanQ1Q2.sh
2. cleanQ3.sh
3. cleanQ4.sh

This is necessary as some scripts operate on CSV's created as outputs from earlier scripts.

cleanQ1Q2.sh
- The removal of the erroneous string ”#]”
- Changing to a comma delimited file

cleanQ3.sh
- Removal of the columns with non-useful values which included “YLA” & “CONF”

cleanQ4.sh
- Using the dictionary file to find and replace country code with country name