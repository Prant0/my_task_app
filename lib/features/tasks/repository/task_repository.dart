import 'package:task_manager/core/db/app_database.dart';
import 'package:task_manager/features/tasks/models/task.dart';

class TaskRepository {
  final AppDatabase _dbProvider = AppDatabase();

  Future<List<Task>> getAll() async {
    final db = await _dbProvider.database;
    final maps = await db.query('tasks', orderBy: 'id DESC');
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<List<Task>> searchTasks(String query) async {
    final db = await _dbProvider.database;
    final maps = await db.query(
      'tasks',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<List<Task>> getTasksByFilter({
    String? category,
    String? priority,
    String? status,
  }) async {
    final db = await _dbProvider.database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    List<String> conditions = [];
    if (category != null && category.isNotEmpty) {
      conditions.add('category = ?');
      whereArgs.add(category);
    }
    if (priority != null && priority.isNotEmpty) {
      conditions.add('priority = ?');
      whereArgs.add(priority);
    }
    if (status != null && status.isNotEmpty) {
      conditions.add('status = ?');
      whereArgs.add(status);
    }

    if (conditions.isNotEmpty) {
      whereClause = conditions.join(' AND ');
    }

    final maps = await db.query(
      'tasks',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'id DESC',
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<List<Task>> getPendingTasks() async {
    final db = await _dbProvider.database;
    final maps = await db.query(
      'tasks',
      where: 'status = ?',
      whereArgs: ['pending'],
      orderBy: 'id DESC',
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<List<Task>> getCompletedTasks() async {
    final db = await _dbProvider.database;
    final maps = await db.query(
      'tasks',
      where: 'status = ?',
      whereArgs: ['completed'],
      orderBy: 'id DESC',
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<int> insert(Task task) async {
    final db = await _dbProvider.database;
    return db.insert('tasks', task.toMap());
  }

  Future<int> update(Task task) async {
    final db = await _dbProvider.database;
    return db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> markAsCompleted(int id) async {
    final db = await _dbProvider.database;
    return db.update(
      'tasks',
      {'status': 'completed'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> markAsPending(int id) async {
    final db = await _dbProvider.database;
    return db.update(
      'tasks',
      {'status': 'pending'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dbProvider.database;
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
