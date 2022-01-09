#!/bin/bash
# Script that finds the number of reviews for each region

sed -i 's/No.Reviews/No_Reviews/' spark.csv

/spark/bin/spark-shell << EOF

val RestaurantDF = spark.read.format("com.databricks.spark.csv").option("header", "true").option("delimiter", ",").option("inferSchema", "true").load("/home/spark.csv")
RestaurantDF.registerTempTable("RestaurantTable")
spark.sql("SELECT Region, SUM(No_Reviews) AS SumReviews FROM RestaurantTable GROUP BY Region ORDER BY SumReviews DESC ").collect.foreach(println)


EOF
