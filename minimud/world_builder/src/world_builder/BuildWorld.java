package world_builder;


import MiniMUDShared.RegularExpressions;

public class BuildWorld 
{
	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		System.out.println("Starting Mini MUD server.");

		int nPort = 0;
		String strUser = "";
		String strPassword = "";
		String strDataFile = "./world_data.xml";
		String strDBServer = "";
		
		RegularExpressions regEx = new RegularExpressions();
		
		DatabaseConnector m_dbConn = null;
		
		while(true)
		{
			if(args.length < 4)
			{
				System.out.println("Invalid number of arguments.");
				break;
			}
			
			// Validate server format
			if(regEx.stringMatchesRegEx(args[0], RegularExpressions.RegExID.IP)
					|| regEx.stringMatchesRegEx(args[0], RegularExpressions.RegExID.DOMAIN))
			{
				strDBServer = args[0];
			}
			else
			{
				System.out.println("Invalid server name or IP address specified.");
				break;
			}
			
			// Validate port number format
			if(regEx.stringMatchesRegEx(args[1], RegularExpressions.RegExID.PORT))
			{
				nPort = Integer.parseInt(args[1]);
			}
			else
			{
				System.out.println("Invalid port number specified.");
				break;
			}
			
			// Validate user name format
			if(regEx.stringMatchesRegEx(args[2], RegularExpressions.RegExID.USERNAME))
			{
				strUser = args[2];
			}
			else
			{
				System.out.println("Invalid user name.");
				break;
			}
			
			// Validate password format
			if(regEx.stringMatchesRegEx(args[3], RegularExpressions.RegExID.PASSWORD))
			{
				strPassword = args[3];
			}
			else
			{
				System.out.println("Invalid password format.");
				break;
			}
			
			if(args.length == 5)
			{
				strDataFile = args[4];
			}
			
			try
			{	
				m_dbConn = new DatabaseConnector(strDBServer, nPort, strUser, strPassword);
				m_dbConn.connect();
				
				// Drop old tables
				m_dbConn.dropTable("rooms");
				m_dbConn.dropTable("action_results");
				m_dbConn.dropTable("actions");
				m_dbConn.dropTable("characters");
				m_dbConn.dropTable("items");
				m_dbConn.dropTable("moves");
				m_dbConn.dropTable("npcs");
				m_dbConn.dropTable("objects");
				
				// Build database tables
				m_dbConn.addTable("CREATE TABLE rooms (ID INT NOT NULL," +
						"name VARCHAR(30) NOT NULL,description VARCHAR(2000) NOT NULL, " +
						"PRIMARY KEY ( id ));");				
				
				m_dbConn.addTable("CREATE TABLE moves (RoomID INT NOT NULL, direction VARCHAR(20) NOT NULL," +
						"NextRoomID INT NOT NULL, description VARCHAR(100) NOT NULL," +
						"PRIMARY KEY ( RoomID, direction ));");
				
				
				m_dbConn.addTable("CREATE TABLE npcs (ID INT NOT NULL, name VARCHAR(30) NOT NULL, " +
						"description VARCHAR(2000) NOT NULL, intro VARCHAR(1000) NOT NULL, " +
						"PRIMARY KEY ( ID ) );");
				
				m_dbConn.addTable("CREATE TABLE actions ( ObjectID INT NOT NULL, name VARCHAR(50) NOT NULL, " +
						"result VARCHAR(200) NOT NULL, PRIMARY KEY ( ObjectID ) );");
				
				m_dbConn.addTable("CREATE TABLE objects ( ID INT NOT NULL, name VARCHAR(50) NOT NULL, " +
						"description VARCHAR(2000) NOT NULL, PRIMARY KEY ( ID ) );");
				
				m_dbConn.addTable("CREATE TABLE action_results ( ID INT NOT NULL, Type INT NOT NULL, Text VARCHAR(100), " +
						"ItemID INT, Value INT, PRIMARY KEY ( ID ) );");
				
				m_dbConn.addTable("CREATE TABLE items ( ID INT NOT NULL, name VARCHAR(50) NOT NULL, " +
						"description VARCHAR(1000) NOT NULL, PRIMARY KEY ( ID ));");
				
				m_dbConn.addTable("CREATE TABLE characters ( username VARCHAR(32) NOT NULL, pwd_hash VARBINARY(100) NOT NULL, " +
						"pwd_salt VARBINARY(16) NOT NULL, created DATE NOT NULL, description VARCHAR(1000), xp INT, gold INT, " +
						"health INT, PRIMARY KEY ( username ));");
				
				// Import world data from XML files
				WorldImporter worldImp = new WorldImporter(strDataFile, m_dbConn);
				
				worldImp.importData();
				
				m_dbConn.disconnect();
			}
			catch(Exception e)
			{
				System.out.println("Exception in main(): " + e);
			}
			
			break;
		}
	}

}