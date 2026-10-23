import 'package:minitodo/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'task.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT,
          isDone INTEGER NOT NULL DEFAULT 0
          )

        ''');
      },
    );

    return database;
  }

  static Future<int> insertTask(TaskModel task) async {
    final db = await initDatabase();
    final data = task.toMap();
    data.remove('id');

    final id = await db.insert('tasks', data);
    return id;
  }

  static Future<List<TaskModel>> getTasks() async {
    final db = await initDatabase();
    final maps = await db.query('tasks');
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }

  static Future<TaskModel?> getTaskByID(int id) async {
    final db = await initDatabase();
    final map = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    if (map.isEmpty) {
      return null;
    }
    return TaskModel.fromMap(map.first);
  }

  static Future<int> updateTask(TaskModel task) async {
    final db = await initDatabase();
    final data = task.toMap();
    data.remove('id');

    final result = await db.update(
      'tasks',
      data,
      where: 'id = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  static Future<int> deleteTask(int id) async {
    final db = await initDatabase();
    final result = await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
