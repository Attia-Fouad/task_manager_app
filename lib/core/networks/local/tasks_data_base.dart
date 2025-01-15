import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  static final TaskDatabase _instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  factory TaskDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        todo TEXT NOT NULL,
        completed INTEGER NOT NULL,
        userId INTEGER NOT NULL
      )
    ''');
  }
}
