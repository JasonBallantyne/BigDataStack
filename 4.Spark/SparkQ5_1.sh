# Script determines the most frequently occuring term in the review column that 
# doesn't include one of the following stop words: "A", "The", "of" - Part 2

/spark/bin/spark-shell << EOF

val spark_rdd = sc.textFile("/home/clean_fifthcol/cleaned_file.csv")

spark_rdd.flatMap(line => line.split(",")(0).split(" ")).map(word => (word, 1)).reduceByKey( _ + _).sortBy(T => T._2,false).first()

EOF
