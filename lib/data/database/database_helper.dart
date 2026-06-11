import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath =
        await getDatabasesPath();

    final path = join(
      dbPath,
      'feedbee.db',
    );

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE feedbacks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loginType TEXT,
        name TEXT,
        email TEXT,
        mobile TEXT,
        issueTitle TEXT,
        issueDescription TEXT,
        imagePath TEXT,
        videoPath TEXT,
        createdAt TEXT
      )
    ''');
  }
}