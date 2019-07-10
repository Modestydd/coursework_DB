import java.io.*;
import java.sql.*;
import java.util.ArrayList;

public class Clone_backup extends DbBasic{
	private ResultSet rs = null;
	
	private ArrayList<String> columnName = new ArrayList<String>();
	private ArrayList<String> columnTypeName = new ArrayList<String>();
	private ArrayList<String> primaryKey = new ArrayList<String>();
	private ArrayList<String> foreignKey = new ArrayList<String>();
	private ArrayList<String> referTable = new ArrayList<String>();
	private ArrayList<String> referKey = new ArrayList<String>();
	private ArrayList<String> createIndex = new ArrayList<String>();
	private ArrayList<String> nullable = new ArrayList<String>();
	private ArrayList<String> tableNames = new ArrayList<String>();	
	
	
	private DatabaseMetaData data;
	/*
	 * Creates a connection to the named database
	 */
	Clone_backup ( String dbName ) throws SQLException {
		super( dbName );
		data = con.getMetaData();
	}
	/**
	 * Generate "CREATE TABLE/INDEX" and "INSERT" statement
	 * @param db
	 * @throws SQLException
	 * @throws IOException
	 */
	public void createAll(String db) throws SQLException, IOException {
		createOrder();										// Generate correct order of table creation
		for(String name : tableNames) {
			createSta(db, name);							// Generate CREATE TABLE statements	
			getIndex(name);									// Generate CREATE INDEX statements
			clear();										// Clear ArrayLists
		}
		if(createIndex.size()>0)							// Close the final "CREATE INDEX" statement
			createIndex.set(createIndex.size()-1, createIndex.get(createIndex.size()-1)+");");
		for(String item: createIndex) 
			write("create_table_" + db + ".sql", item);
		createIndex.clear();
		tableNames.clear();
	}
	
	/**
	 * Generate correct order of table creation
	 * @throws SQLException
	 */
	public void createOrder() throws SQLException {		
		ResultSet rs =  data.getTables(null, null, null, new String[]{"TABLE","VIEW"});	
		while (rs.next()) {
			// Foreign key 
			ResultSet fks = data.getImportedKeys(null, null, rs.getString(3));
			while(fks.next()){
				int index = tableNames.indexOf(rs.getString(3));	// Position of table, -1 if not exists
				String fore = fks.getString("PKTABLE_NAME");
				if(index == -1) {									
					if(!tableNames.contains(fore)) 					// Existence of foreign table
						tableNames.add(fore);						// If not exists, add
					tableNames.add(rs.getString(3));				// Add table into ArrayList
				}
				else {
					if(!tableNames.contains(fore)) 
						tableNames.add(index, fore);
					else {
						if(tableNames.indexOf(fore)>index) {		// If foreign table is created later than table
							tableNames.remove(fore);				// Change fore to the front of the table
							tableNames.add(index, fore);
						}
					}
				}
			}
			if(!tableNames.contains(rs.getString(3))) 
				tableNames.add(rs.getString(3));
		}
	}
	
	/**
	 * Clear ArrayList
	 */
	public void clear() {
		columnName.clear();
		columnTypeName.clear();
		primaryKey.clear();
		foreignKey.clear();
		referTable.clear();
		referKey.clear();
		nullable.clear();
	}
	
	/**
	 * Generate "CREATE TABLE" statements
	 * @param db
	 * @param table
	 * @throws SQLException
	 * @throws IOException
	 */
	public void createSta(String db, String table) throws SQLException, IOException {
		getColumnNames(table);									//Get the name of each column
		getKeys(table);											//Get primary and foreign keys
		String create = "CREATE TABLE \""+table+"\" (\n\t";
		for(int i = 0; i < columnName.size(); i++) {
			create += (i==0)? ("\""+columnName.get(i)+ "\" " +  columnTypeName.get(i)):
				(",\n\t\"" + columnName.get(i) +"\" " +columnTypeName.get(i));
			// not null
			create += (nullable.get(i).equals("0"))? (" not null"):("");
		}
		// Concat primary key
		for(int i = 0; i < primaryKey.size(); i++) {
			create += (i==0)?(",\n\tprimary key(\"" + primaryKey.get(i) + "\""):(", \""+ primaryKey.get(i)+"\"");
			create += (i ==primaryKey.size()-1)?(")"):("");
		}
		// Concat foreign keys
		foreConcat(db , create); 
		create = "";
		insert(db, table);
	}
	
	/**
	 * Generate foreign keys
	 * @param db
	 * @param create
	 * @throws IOException
	 */
	public void foreConcat(String db, String create) throws IOException {
		for(int i = foreignKey.size()-1; i>-1; i--) 
			create += ",\n\tforeign key(\""+ foreignKey.get(i)+"\") references \"" + referTable.get(i)+"\" (\""+referKey.get(i)+"\")";
		create += ");\n\n";
		
		
//		if(foreignKey.size()!=0) {
//			for(int i = foreignKey.size()-1; i>-1; i--) 
//				create += (i == 0)?(",\n\tforeign key(\""+ foreignKey.get(i)+"\") references \"" + referTable.get(i)+"\" (\""+referKey.get(i)+"\"));\n\n"):
//					(",\n\tforeign key(\""+ foreignKey.get(i)+"\") references \"" + referTable.get(i)+"\" (\""+referKey.get(i)+"\")");	
//		}
//		else 
//			create += ");\n\n";
		write("create_table_"+db+".sql", create);
		System.out.println(create);
	}
	
	/**
	 * Get column info.
	 * @param table
	 * @throws SQLException
	 */
	public void getColumnNames(String table) throws SQLException {	
		DatabaseMetaData data = con.getMetaData();
		rs = data.getColumns(null, null, table, null);
		
		while(rs.next()) {				
			columnName.add(rs.getString("COLUMN_NAME"));		// Column name	
			columnTypeName.add(rs.getString("TYPE_NAME"));		// Type name
			nullable.add(rs.getString("NULLABLE"));				// Not null
		}
	}
	
	/**
	 * Get primary keys and foreign keys
	 * @param table
	 * @throws SQLException
	 */
	public void getKeys(String table) throws SQLException {
		ResultSet rs = data.getPrimaryKeys(null, null, table);
		while(rs.next()) 
			primaryKey.add(rs.getString("COLUMN_NAME"));			// primary key
		
		ResultSet fks = data.getImportedKeys(null, null, table);
		while(fks.next()){
			referTable.add(fks.getString("PKTABLE_NAME"));			// Reference table
			referKey.add(fks.getString("PKCOLUMN_NAME"));			// Reference column
			foreignKey.add(fks.getString("FKCOLUMN_NAME"));			// Foreign key
		}
	}
	
	/**
	 * Get indexs
	 * @param table
	 * @throws SQLException
	 */
	public void getIndex(String table) throws SQLException {
		DatabaseMetaData data = con.getMetaData();
		rs = data.getIndexInfo(null, null, table, false, true);
		String index = "";
		while(rs.next()) {			
			if(rs.getString("INDEX_NAME").contains("sqlite_autoindex_"))
				continue;
			if(rs.getString("ORDINAL_POSITION").equals("1")) {
				if(!(createIndex.size() == 0)) 
					createIndex.set(createIndex.size()-1, createIndex.get(createIndex.size()-1) +");\n");
				index = (rs.getString("NON_UNIQUE").equals("1")) ? ("CREATE INDEX \""):("CREATE UNIQUE INDEX \"");
				index += rs.getString("INDEX_NAME") + "\" ON \""+rs.getString("TABLE_NAME")+"\" (\""+ rs.getString("COLUMN_NAME");
				if(rs.getString("ASC_OR_DESC") == null)
					index += "\"";
				else if(rs.getString("ASC_OR_DESC").equals("A"))
					index += " ASC\"";
				else if(rs.getString("ASC_OR_DESC").equals("B"))
					index += " DESC";
				
			
				createIndex.add(index);
			}
			else {
				if(rs.getString("ASC_OR_DESC") == null)
					createIndex.set(createIndex.size()-1, createIndex.get(createIndex.size()-1) + ", \"" +rs.getString("COLUMN_NAME")+"\"");
				else if(rs.getString("ASC_OR_DESC").equals("A"))
					createIndex.set(createIndex.size()-1, createIndex.get(createIndex.size()-1) + ", \"" +rs.getString("COLUMN_NAME")+" ASC\"");
				else if(rs.getString("ASC_OR_DESC").equals("B"))
					createIndex.set(createIndex.size()-1, createIndex.get(createIndex.size()-1) + ", \"" +rs.getString("COLUMN_NAME")+" DESC\"");
			}
		}
	}
	
	public void insert(String db, String table) throws SQLException, IOException {
		String s = "SELECT * FROM \""+table+"\";";
		PreparedStatement ps = con.prepareStatement(s);
		ResultSet result = ps.executeQuery();
		String insert = "INSERT INTO \""+table+"\" VALUES (";
		String insert1 = insert;
		String insert2 = insert;
		ResultSetMetaData rsmd = ps.getMetaData();		
		int size = rsmd.getColumnCount();
		while(result.next()) {
			insert1 = insert;
			insert2 = insert;
			for(int i = 1; i <= size; i++) {
				String res = result.getString(i);
				res = (res == null)? (null):(res.contains("\"")?(res.replace("\"", "\'")):(res));
				insert1 += (i == size)? (res +");\n"):(res+", ");
				insert2 += (i == size)? ("\"" + res +"\");\n"):("\"" + res +"\", ");
			}
			write("insert1"+db+".sql", insert1);
			write("insert"+db+".sql", insert2);
			System.out.print(insert2);
		}
	}

	public void write(String file, String content) throws IOException {
		File f =new File(file);
		//if file doesnt exists, then create it
		if(!f.exists())
			f.createNewFile();
		//true = append file
		FileWriter fileWritter = new FileWriter(file,true);
		fileWritter.write(content);
		fileWritter.close();
	}
}
