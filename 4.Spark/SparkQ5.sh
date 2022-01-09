#!/bin/bash
# Script determines the most frequently occuring term in the review column that 
# doesn't include one of the following stop words: "A", "The", "of" - Part 1
 
sed -i 's/No.Reviews/No_Reviews/' spark.csv

cut -d, -f5 spark.csv > fifthcol.csv

/spark/bin/spark-shell << EOF

import org.apache.spark.ml.feature.StopWordsRemover

val sparkdf = spark.read.text("/home/fifthcol.csv").map( row => row.getString(0).split(""" """))

val stopremover = new StopWordsRemover().setInputCol("value").setOutputCol("removed").setStopWords(Array("the", "The", "a", "A", "of", "Of"))

val newsparkdf = stopremover.transform(sparkdf)

newsparkdf.select("removed").map(row => row.getSeq[String](0).mkString(" ")).write.text("/home/clean_fifthcol")

EOF
