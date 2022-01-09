In other to run these queries, it is necessary to firstly load the data from the given file (spark.csv)
To load it in as a Dataframe, run the following query:
- val RestaurantDF =
spark.read.format("com.databricks.spark.csv").option("header",
"true").option("delimiter", ",").option("inferSchema",
"true").load("/home/spark.csv")

Before performing spark SQL queries, ensure the following line is ran:
- RestaurantDF.registerTempTable("RestaurantTable")

Each of the scripts read in the file and change the column them so they do not need to be read in, in any particular order.
The exception is SparkQ5_1.sh which requires SparkQ5.sh to be ran prior.



