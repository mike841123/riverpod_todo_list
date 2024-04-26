import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/data/data.dart';

import '../../utils/app_keys.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();

  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDb();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppKeys.dbTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        note TEXT,
        date TEXT,
        time TEXT,
        category TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<int> addTask(TaskResp task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        AppKeys.dbTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<TaskResp>> getAllTasks(String selectDate) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppKeys.dbTable,
      where: 'date = ?',
      whereArgs: [selectDate],
      orderBy: "id DESC",
    );
    return List.generate(
      maps.length,
      (index) {
        return TaskResp.fromJson(maps[index]);
      },
    );
  }

  Future<int> updateTask(TaskResp task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        AppKeys.dbTable,
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<int> deleteTask(TaskResp task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          "todos",
          where: 'id = ?',
          whereArgs: [task.id],
        );
      },
    );
  }
}
