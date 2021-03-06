# Hadoop


Please refer to [Hadoop_Tasks](https://github.com/JasonBallantyne/BigData/blob/main/3.Hadoop/Hadoop_Tasks.pdf) for full list of objectives.

MapReduce expects the Input and Output paths to be the directories in HDFS.
Before executing the MapReduce Jobs, you must firstly do the following:

1. Ensure the directories are set up, this can be done using:
    * $ hdfs dfs -mkdir /dataset1
    * $ hdfs dfs -mkdir /input

2. Ensure the input directory is populated with the supplied "hadoop.csv" file so the MapReduce Job knows what file to execute on. This can be done using the following command:
    * $ hdfs dfs -copyFromLocal hadoop.csv /input

3. To execute the files carry out the following:
    * $ export HADOOP_CLASSPATH=/usr/lib/jvm/java-1.8.0-openjdk-amd64/lib/tools.jar
    * $ hadoop com.sun.tools.javac.Main {filename}.java
    * $ jar cf wc.jar {filename}*.class
    * $ hadoop jar wc.jar {filename} /input /output2

4. To check the job has executed correctly, carry out the following command:
    * $ hdfs dfs -cat /output2/part-r-00000
