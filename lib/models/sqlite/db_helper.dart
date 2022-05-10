import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Cat {
  final int id;
  final String name;
  final int age;

  Cat({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAge: age,
    };
  }

  @override
  String toString() {
    return 'Cat{id:$id, name: $name, age: $age}';
  }
}

class DatabaseHelper {
  static final _databaseName = 'cats.db';
  static final _databaseVersion = 1;

  static final table = "cats";

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnAge = 'age';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
  ''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the inserted row.
  Future<void> insertCat(Cat cat) async {
    final db = await database;
    await db.insert(
      table,
      cat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // retrive all cats.
  Future<List<Cat>> cats() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('cats');
    return List.generate(maps.length, (index) {
      return Cat(
        id: maps[index][columnId],
        name: maps[index][columnName],
        age: maps[index][columnAge],
      );
    });
  }

  // update function
  Future<void> updateCat(Cat cat) async {
    final db = await database;
    await db.update(
      table,
      cat.toMap(),
      where: 'id = ?',
      whereArgs: [cat.id],
    );
  }

  // delete function
  Future<void> deleteCat(int id) async {
    final db = await database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
