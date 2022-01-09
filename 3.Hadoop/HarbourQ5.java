import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
/*
This class returns all the harbours connected to Midnightblue-Epsilon including Midnightblue-Epsilon itself
 */
public class HarbourQ5 {

  public static class TokenizerMapper
       extends Mapper<Object, Text, Text, IntWritable>{

    private final static IntWritable one = new IntWritable(1);

    private Text Route = new Text();
	private static String key_value;


    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
      // Creating a StringTokenizer
      StringTokenizer itr = new StringTokenizer(value.toString());
      

	while (itr.hasMoreTokens()) {

		String[] split = itr.nextToken().split(",");
    // If the port column is equalled to Midnightblue-Epsilon
    // Store the contents of the route in the variable key_value
		if (split[0].trim().equals("Midnightblue-Epsilon")){
			key_value = new String(split[2].trim());
		}
		
    // If the route column is equal to our varibale, key_value
    // Return the ports that belong to this route

		if(split[2].trim().equals(key_value)){
			Route.set(split[0].trim());

		context.write(Route, one);
	}
      }
    }
  }

  public static class IntSumReducer
       extends Reducer<Text,IntWritable,Text,IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      context.write(key, result);
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "word count");
    job.setJarByClass(HarbourQ5.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
