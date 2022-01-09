#!/bin/bash
# Script that determines the restaurant with the longest name

sed -i 's/No.Reviews/No_Reviews/' spark.csv

/spark/bin/spark-shell << EOF

val RestaurantDF = spark.read.format("com.databricks.spark.csv").option("header", "true").option("delimiter", ",").option("inferSchema", "true").load("/home/spark.csv")
RestaurantDF.registerTempTable("RestaurantTable")

spark.sql("SELECT Restaurant FROM RestaurantTable WHERE LENGTH(Restaurant) = (SELECT MAX(LENGTH(Restaurant)) FROM RestaurantTable)").collect.foreach(println)

EOF
