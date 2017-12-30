import java.io.IOException;
import java.sql.*;
import java.util.Scanner;

class FindPilot {
  
  
 public static void main(String args[]) {
  String dbSys = null;
  Scanner in = null;
  String origin = "";
  String destination = "";
  
  
  
  try {
   in = new Scanner(System.in);
   System.out
     .println("Please enter information to test connection to the database");
   dbSys = readEntry(in, "Using Oracle (o), MySql (m) or HSQLDB (h)? ");

  } catch (IOException e) {
   System.out.println("Problem with user input, please try again\n");
   System.exit(1);
  }
  // Prompt the user for connect information
  String user = null;
  String password = null;
  String connStr = null;
  String yesNo;
  try {
   if (dbSys.equals("o")) {
    user = readEntry(in, "user: ");
    password = readEntry(in, "password: ");
    yesNo = readEntry(in,
      "use canned Oracle connection string (y/n): ");
    if (yesNo.equals("y")) {
     String host = readEntry(in, "host: ");
     String port = readEntry(in, "port (often 1521): ");
     String sid = readEntry(in, "sid (site id): ");
      origin = readEntry(in, "Origin:");
      destination = readEntry(in, "Destination:");
     connStr = "jdbc:oracle:thin:@" + host + ":" + port + ":"
       + sid;
    } else {
     connStr = readEntry(in, "connection string: ");
    }
   } else if (dbSys.equals("m")) {// MySQL--
    user = readEntry(in, "user: ");
    password = readEntry(in, "password: ");
    yesNo = readEntry(in,
      "use canned MySql connection string (y/n): ");
    if (yesNo.equals("y")) {
     String host = readEntry(in, "host: ");
     String port = readEntry(in, "port (often 3306): ");
     origin = readEntry(in, "Origin:");
     destination = readEntry(in, "Destination:");
     String db = user + "db";
     connStr = "jdbc:mysql://" + host + ":" + port + "/" + db;
    } else {
     connStr = readEntry(in, "connection string: ");
    }
   } else if (dbSys.equals("h")) { // HSQLDB (Hypersonic) db
    yesNo = readEntry(in,
      "use canned HSQLDB connection string (y/n): ");
    if (yesNo.equals("y")) {
     String db = readEntry(in, "db or <CR>: ");
     connStr = "jdbc:hsqldb:hsql://localhost/" + db;
    } else {
     connStr = readEntry(in, "connection string: ");
    }
    user = "sa";
    password = "";
   } else {
    user = readEntry(in, "user: ");
    password = readEntry(in, "password: ");
    connStr = readEntry(in, "connection string: ");
   }
  } catch (IOException e) {
   System.out.println("Problem with user input, please try again\n");
   System.exit(3);
  }
  System.out.println("using connection string: " + connStr);
  System.out.print("Connecting to the database...");
  System.out.flush();
  Connection conn = null;
  // Connect to the database
  // Use finally clause to close connection
  try {
   conn = DriverManager.getConnection(connStr, user, password);
   System.out.println("connected.");
   int x = findFlights(conn, origin, destination);
   findPilots(conn, x, origin, destination);
  } catch (SQLException e) {
   System.out.println("Problem with JDBC Connection\n");
   printSQLException(e);
   System.exit(4);
  } finally {
   // Close the connection, if it was obtained, no matter what happens
   // above or within called methods
   if (conn != null) {
    try {
     conn.close(); // this also closes the Statement and
         // ResultSet, if any
    } catch (SQLException e) {
     System.out
       .println("Problem with closing JDBC Connection\n");
     printSQLException(e);
     System.exit(5);
    }
   }
  }
 }
 
 static int findFlights(Connection conn, String origin, String destination) throws SQLException {

  Statement stmt = conn.createStatement();
  ResultSet rset = null;
  Scanner in = null;
  
  try{ 
   rset = stmt.executeQuery("select f.flno, f.distance, f.arrives-f.departs from flights f where f.origin='" + origin + "' AND f.destination='" + destination + "'");   
   
   while(rset.next()){  
   return Integer.valueOf(rset.getString(2));  
   }
  } finally { 
   stmt.close(); 
  }
  return -1;
 }
 
 static void findPilots(Connection conn, int distance, String origin, String destination) throws SQLException {
   
   Statement stmt = conn.createStatement();
   ResultSet rset = null;
   
   try{
     rset = stmt.executeQuery("select distinct e.ename, e.salary, a.aname, a.cruisingrange from  aircraft a, employees e, certified c where  c.eid=e.eid AND c.aid=a.aid  AND a.cruisingrange > " + distance + "ORDER BY e.salary ASC");
     
     while(rset.next()){
     
     System.out.println("Flight: from " + origin + " to " + destination + ", distance " + distance);
     System.out.println("Pilot chosen: " + rset.getString(1) + ", salary " + rset.getString(2));
     System.out.println("Aircraft chosen: " + rset.getString(3) + ", cruisingrange " + rset.getString(4));
     
     break;
     }
       
     
   } finally {
     stmt.close();
   }  
 }

 
 
 // print out all exceptions connected to e by nextException or getCause
 static void printSQLException(SQLException e) {
  // SQLExceptions can be delivered in lists (e.getNextException)
  // Each such exception can have a cause (e.getCause, from Throwable)
  while (e != null) {
   System.out.println("SQLException Message:" + e.getMessage());
   Throwable t = e.getCause();
   while (t != null) {
    System.out.println("SQLException Cause:" + t);
    t = t.getCause();
   }
   e = e.getNextException();
  }
 }

 // super-simple prompted input from user
 public static String readEntry(Scanner in, String prompt)
   throws IOException {
  System.out.print(prompt);
  return in.nextLine().trim();
 }
}
