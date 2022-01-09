MapReduce expects the Input and Output paths to be the directories in HDFS.
Before executing the MapReduce Jobs, you must firstly do the following:

- Ensure the directories are set up, this can be done using:
$ hdfs dfs -mkdir /dataset1
$ hdfs dfs -mkdir /input

- Ensure the input directory is populated with the supplied "hadoop.csv" file so the MapReduce Job knows what file to execute on. This can be done using the following command:
$ hdfs dfs -copyFromLocal hadoop.csv /input

To execute the files carry out the following:
$ export HADOOP_CLASSPATH=/usr/lib/jvm/java-1.8.0-openjdk-amd64/lib/tools.jar
$ hadoop com.sun.tools.javac.Main {filename}.java
$ jar cf wc.jar {filename}*.class
$ hadoop jar wc.jar {filename} /input /output2

To check the job has executed correctly, carry out the following command:
$ hdfs dfs -cat /output2/part-r-00000