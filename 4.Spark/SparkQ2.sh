#!/bin/bash
# Script that finds the restaurant with the highest number of reviews

sed -i 's/No.Reviews/No_Reviews/' spark.csv

/spark/bin/spark-shell << EOF

val RestaurantDF = spark.read.format("com.databricks.spark.csv").option("header", "true").option("delimiter", ",").option("inferSchema", "true").load("/home/spark.csv")
RestaurantDF.registerTempTable("RestaurantTable")

spark.sql("SELECT Restaurant, No_Reviews from RestaurantTable WHERE No_Reviews IN (SELECT MAX(No_Reviews) FROM RestaurantTable)").collect.foreach(println)

EOF
