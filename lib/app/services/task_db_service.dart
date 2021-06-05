import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoey/app/models/task.dart';

class TaskDbService {
  // Singleton Class
  static TaskDbService? get instance =>
      _instance == null ? _instance = TaskDbService._internal() : _instance;
  static TaskDbService? _instance;
  TaskDbService._internal();

  final String _tableName = 'task';
  final String _colId = 'id';
  final String _colTitle = 'title';
  final String _colIsChacked = 'isChacked';

  Future<Database> get db async {
    return (_db == null ? _db = await _initDatabase() : _db) as Database;
  }

  Database? _db;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''

          CREATE TABLE $_tableName (
            $_colId TEXT PRIMARY KEY NOT NULL,
            $_colTitle TEXT NOT NULL,
            $_colIsChacked INTEGER NOT NULL
          )    
  
      ''');
    });
  }

  Future<Task> insert({required Task task}) async {
    try {
      final dbClient = await db;

      await dbClient.insert(
        _tableName,
        Task.toMap(task),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return task;
    } catch (e) {
      throw e;
    }
  }

  Future<Task> itemById({required String id}) async {
    try {
      return (await items()).where((task) => task.id == id).first;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Task>> items() async {
    try {
      final dbClient = await db;
      final mapList = await dbClient.query(_tableName);
      return mapList.map((task) => Task.fromMap(task)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<Task> update({required id, required Task task}) async {
    try {
      final dbClient = await db;
      await dbClient.update(
        _tableName,
        Task.toMap(task),
        where: '$_colId = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return task;
    } catch (e) {
      throw e;
    }
  }

  Future<void> delete({required String? id}) async {
    try {
      final dbClient = await db;
      await dbClient.delete(_tableName, where: '$_colId = ?', whereArgs: [id]);
      return null;
    } catch (e) {
      throw e;
    }
  }
}
