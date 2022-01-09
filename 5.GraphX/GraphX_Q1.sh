# Script that imports the data and creates a graph representing the data

/spark/bin/spark-shell << EOF

// Importing the packages
import org.apache.spark._
import org.apache.spark.rdd.RDD
import org.apache.spark.graphx._
import org.apache.spark.util.IntParam
import org.apache.spark.graphx.util.GraphGenerators

// Creating a mapper using hadoop_mirrored.csv
case class harb_map(HarbourName:String, HarbourNo:Long, Route: String, RouteNo:Long)
def parsingHarbMap(str: String): harb_map = {val line = str.split(","); harb_map(line(0), line(1).toLong, line(2), line(3).toLong)}
var MapRDD = sc.textFile("./hadoop_mirrored.csv")
val header = MapRDD.first()
MapRDD = MapRDD.filter(row => row != header)
val harbourMapRDD = MapRDD.map(parsingHarbMap).cache()
val NewMapHarbour = harbourMapRDD.flatMap(har => Seq((har.HarbourName, har.HarbourNo))).distinct
val harbourMap = NewMapHarbour.map{ case (a, b) => (a -> b) }.collect.toMap

// Creating the vertices using GraphX_Edges.csv
case class Harbour(HarbourName:String, Route: String)
def parsingHarbour(str: String): Harbour = {val line = str.split(","); Harbour(line(1), line(2))}
var harbourRDD = sc.textFile("./GraphX_Edges.csv")
val harbourHeader = harbourRDD.first()
harbourRDD = harbourRDD.filter(row => row != harbourHeader)
val harbourNewRDD = harbourRDD.map(parsingHarbour).cache()
val harbour = harbourNewRDD.flatMap(h => Seq((harbourMap(h.HarbourName), h.HarbourName))).distinct

// Creating the edges using new_hadoop_edges.csv
case class Route(Route: String, From:String, To:String)
def parsingRoute(str: String): Route = {val line = str.split(","); Route(line(0), line(1), line(2))}
var routeRDD = sc.textFile("./GraphX_Edges.csv")
val routeHeader = routeRDD.first()
routeRDD = routeRDD.filter(row => row != routeHeader)
val newRouteRDD = routeRDD.map(parsingRoute).cache()
val route = newRouteRDD.map(ro =>((harbourMap(ro.From), harbourMap(ro.To), ro.Route))).distinct
val edges = route.map { case (origin, destination, route) => Edge(origin, destination, route) }

// Creating the graph
val nowhere = "nowhere"
val graph = Graph(harbour, edges, nowhere)

EOF
