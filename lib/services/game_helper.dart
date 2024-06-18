import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GameHelper {
  static final GameHelper instance = GameHelper._init();

  static Database? _database;

  GameHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('game.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const stepStatusTable = '''
    CREATE TABLE step_status (
      id INTEGER PRIMARY KEY,
      title TEXT,
      action TEXT,
      isCompleted INTEGER,
      isLocked INTEGER
    )
    ''';

    await db.execute(stepStatusTable);
  }

  Future<Map<String, Map<String, StepStatus>>> fetchStepStatuses() async {
    final db = await instance.database;

    final result = await db.query('step_status');

    Map<String, Map<String, StepStatus>> stepStatuses = {
      'Pembibitan': {
        'Panduan YouTube': StepStatus(isCompleted: false, isLocked: false),
        'Halaman Pembibitan': StepStatus(isCompleted: false, isLocked: true),
        'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
      },
      'Perawatan': {
        'Panduan YouTube': StepStatus(isCompleted: false, isLocked: true),
        'Halaman Perawatan': StepStatus(isCompleted: false, isLocked: true),
        'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
      },
      'Panen': {
        'Panduan YouTube': StepStatus(isCompleted: false, isLocked: true),
        'Halaman Panen': StepStatus(isCompleted: false, isLocked: true),
        'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
      },
    };

    for (var row in result) {
      String title = row['title'] as String;
      String action = row['action'] as String;
      bool isCompleted = row['isCompleted'] == 1;
      bool isLocked = row['isLocked'] == 1;

      stepStatuses[title]![action] = StepStatus(isCompleted: isCompleted, isLocked: isLocked);
    }

    return stepStatuses;
  }

  Future<void> insertStepStatus(String title, String action, StepStatus status) async {
    final db = await instance.database;

    await db.insert(
      'step_status',
      {
        'title': title,
        'action': action,
        'isCompleted': status.isCompleted ? 1 : 0,
        'isLocked': status.isLocked ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class StepStatus {
  bool isCompleted;
  bool isLocked;

  StepStatus({required this.isCompleted, required this.isLocked});
}
