import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "appDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'taskTable';
  static final columnId = '_id';
  static final columnUserId = 'userId';
  static final columnTitle = 'title';
  static final columnCompleted = 'completed';
  static final columnDesc = 'description';
  static final columnDateTime = 'dateTime';
  static final columnDuration = 'duration';
  static final columnDateCreated = 'created';
  static final columnDateUpdated = 'updated';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDesc TEXT,
            $columnUserId INTEGER,
            $columnDateTime TEXT,
            $columnDuration INTEGER,
            $columnCompleted INTEGER NOT NULL,
            $columnDateCreated TEXT NOT NULL,
            $columnDateUpdated TEXT NOT NULL
          )
          ''');
    });
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
