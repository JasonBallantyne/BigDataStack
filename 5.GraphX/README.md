Before beggining, two changes were made to each of the attached CVs to alter the raw CVs.

- Firstly, the last row was added to the mirrored column "unknown, 0, unknown, 0" to deal with unknown values, the code to do this was:
echo "nowhere,0,nowhere,0" >> hadoop_mirrored.csv


- Secondly, the index column was removed from the edges file, the code to do this was 
"-d"," -f2,3,4,5  hadoop_edges.csv > GraphX_Edges.csv


This does not need to be redone as this action has been carried out on the given CSVs.