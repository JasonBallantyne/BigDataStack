# Script that determines the number of records the dataset has in total

/spark/bin/spark-shell << EOF

val RestaurantDF = spark.read.format("com.databricks.spark.csv").option("header", "true").option("delimiter", ",").option("inferSchema", "true").load("/home/spark.csv")

RestaurantDF.registerTempTable("RestaurantTable")

spark.sql("SELECT COUNT(*) FROM RestaurantTable").collect.foreach(println)


EOF
