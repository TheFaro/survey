import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:snau_survey/models/models.dart';

class ConstituencyDBHelper {
  static final _databaseName = 'constituency.db';
  static final _databaseVersion = 1;
  static final constituencyTable = 'constituency_table';

  // table column names
  static final columnInkhundlaId = 'inkhundla_id';
  static final columnInkhundlaCode = 'inkhundla_code';
  static final columnRegion = 'region';
  static final columnInkhundla = 'inkhundla';

  ConstituencyDBHelper._privateConstructor();
  static final ConstituencyDBHelper instance =
      ConstituencyDBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    return db.execute('''
      CREATE TABLE constituency (
        $columnInkhundlaId int(11) NOT NULL,
        $columnInkhundlaCode varchar(100) NOT NULL,
        $columnRegion varchar(100) NOT NULL,
        $columnInkhundla varchar(100) NOT NULL
      )
    ''');
  }

  Future<void> insertConstituency(Constituency constituency) async {
    final db = await database;
    await db.insert(
      constituencyTable,
      constituency.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Constituency>> getConstituency() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(constituencyTable);
    return List.generate(
      maps.length,
      (index) => Constituency(
        inkhundlaId: maps[index][columnInkhundlaId],
        inkhundlaCode: maps[index][columnInkhundlaCode],
        region: maps[index][columnRegion],
        inkhundla: maps[index][columnInkhundla],
      ),
    );
  }

  Future<void> updateConstituency(Constituency constituency) async {
    final db = await database;
    await db.update(
      constituencyTable,
      constituency.toMap(),
      where: 'id = ?',
      whereArgs: [constituency.inkhundlaId],
    );
  }
}
