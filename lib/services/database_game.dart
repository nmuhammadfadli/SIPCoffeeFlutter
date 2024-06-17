import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseGame {
  static final DatabaseGame _instance = DatabaseGame._internal();
  factory DatabaseGame() => _instance;
  DatabaseGame._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'game_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE scores(id INTEGER PRIMARY KEY, score INTEGER)',
    );
    await db.insert('scores', {'id': 1, 'score': 0});
  }

  Future<int> getScore() async {
    final db = await database;
    var result = await db!.query('scores', where: 'id = ?', whereArgs: [1]);
    return result.first['score'] as int;
  }

  Future<void> updateScore(int score) async {
    final db = await database;
    await db!.update('scores', {'score': score}, where: 'id = ?', whereArgs: [1]);
  }
}
