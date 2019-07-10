import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class Main {
	Clone myDbUser = null;

	private void go() throws SQLException, IOException{
		System.out.println("In go...");
		myDbUser = new Clone("University.db");	
		myDbUser.createAll("University");
		myDbUser = new Clone("LSH.db");	
		myDbUser.createAll("LSH");
		myDbUser = new Clone("Northwind.db");	
		myDbUser.createAll("Northwind");
		myDbUser = new Clone("Chinook.db");	
		myDbUser.createAll("Chinook");
		myDbUser.write("CloneAll.bat", "pause");
		System.out.println("Processing over");
	
		myDbUser.close();
	}; // end of method "go"
	
	public static void main(String [ ] args) throws SQLException, IOException{
		Main myMain = new Main();
		myMain.go();
	} // end of method "main"

} // end of class "Main"
