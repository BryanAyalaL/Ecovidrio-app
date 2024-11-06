import 'package:mysql1/mysql1.dart';

class Database {
  // Private variable to store the connection
  MySqlConnection? _connection;

  // Connection settings
  final ConnectionSettings settings = ConnectionSettings(
    host: '10.0.2.2',
    port: 3306,
    user: 'root',
    password: 'root',
    db: 'ecovidrio_export',
  );

  // Method to establish a connection
  Future<void> connect() async {
    try {
      _connection = await MySqlConnection.connect(settings);
      print('Connected to the database.');
    } catch (e) {
      print('Error connecting to the database: $e');
    }
  }



  // Method to execute a query
  Future<void> executeQuery(String query, List<dynamic> values) async {

  if (_connection == null) {
    print('No connection available.');
    return;
  }
  try {
    var result = await _connection!.query(query, values);
    print('Query executed successfully: $result');
  } catch (e) {
    print('Error executing query: $e');
  }
}
  }


void main() async {
  // Instantiate the database
  final db = Database();

  // Connect to the database
  await db.connect();

  // Execute a query
  await db.executeQuery(
      'select * from resultado', []);

}
