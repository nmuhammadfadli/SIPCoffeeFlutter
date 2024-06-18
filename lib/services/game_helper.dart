import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GameHelper {
  static final GameHelper instance = GameHelper._init();
  static Database? _database;

  GameHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('steps.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE steps (
      id $idType,
      step TEXT NOT NULL,
      action TEXT NOT NULL,
      isCompleted $boolType,
      isLocked $boolType
    )
    ''');
  }

  Future<void> insertStep(String step, String action, bool isCompleted, bool isLocked) async {
    final db = await instance.database;

    await db.insert(
      'steps',
      {'step': step, 'action': action, 'isCompleted': isCompleted ? 1 : 0, 'isLocked': isLocked ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateStep(String step, String action, bool isCompleted, bool isLocked) async {
    final db = await instance.database;

    await db.update(
      'steps',
      {'isCompleted': isCompleted ? 1 : 0, 'isLocked': isLocked ? 1 : 0},
      where: 'step = ? AND action = ?',
      whereArgs: [step, action],
    );
  }

  Future<Map<String, Map<String, StepStatus>>> fetchSteps() async {
    final db = await instance.database;

    final steps = await db.query('steps');

    Map<String, Map<String, StepStatus>> stepStatus = {
      'Pembibitan': {},
      'Perawatan': {},
      'Panen': {},
    };

    for (var step in steps) {
      final stepName = step['step'] as String;
      final actionName = step['action'] as String;
      final isCompleted = step['isCompleted'] == 1;
      final isLocked = step['isLocked'] == 1;

      stepStatus[stepName]![actionName] = StepStatus(
        isCompleted: isCompleted,
        isLocked: isLocked,
      );
    }

    return stepStatus;
  }

  Future<void> deleteAllSteps() async {
    final db = await instance.database;
    await db.delete('steps');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class StepStatus {
  bool isCompleted;
  bool isLocked;

  StepStatus({required this.isCompleted, required this.isLocked});
}
