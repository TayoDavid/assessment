import 'dart:convert';

import 'package:assessment/data/db/database_helper.dart';
import 'package:assessment/data/model/task.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class TaskRepository {
  Future<List<Task>> loadTasksFromDb() async {
    final db = await DatabaseHelper.instance.database;
    final response = await db.query(DatabaseHelper.table);

    List<Task> tasks = response.map((item) => Task.fromMap(item)).toList();

    return tasks;
  }

  Future<bool> addNewTask(Task task) async {
    final db = await DatabaseHelper.instance.database;
    final response = await db.insert(DatabaseHelper.table, task.toMap());
    return response > 0;
  }

  Future<bool> updateTask(Task task) async {
    final db = await DatabaseHelper.instance.database;
    final response = await db.update(
      DatabaseHelper.table,
      task.toMap(),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [task.id],
    );
    return response > 0;
  }

  Future<bool> deleteTaskWhere(int id) async {
    final db = await DatabaseHelper.instance.database;
    final response = await db.delete(
      DatabaseHelper.table,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    return response > 0;
  }

  Future<List<Task>> fetchRemoteTasks() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      final dataList = jsonDecode(response.body) as List;
      if (response.statusCode == 200 && dataList.isNotEmpty) {
        final lastId = await getLastTask();
        List<Task> tasks = dataList.map((item) {
          return Task.fromJson(
            item as Map<String, dynamic>,
            offsetIdBy: lastId,
          );
        }).toList();
        return tasks;
      }
      return [];
    } catch (_) {
      rethrow;
    }
  }

  Future<int> getLastTask() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.table,
      orderBy: "${DatabaseHelper.columnId} DESC",
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first[DatabaseHelper.columnId];
    } else {
      return 0;
    }
  }

  Future<void> batchUpdate(List<Task> tasks) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final batch = db.batch();
      for (var task in tasks) {
        batch.insert(
          DatabaseHelper.table,
          task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }
}
