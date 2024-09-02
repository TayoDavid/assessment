import 'dart:io';

import 'package:assessment/data/model/task.dart';
import 'package:assessment/repository/repo.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  final repo = TaskRepository();
  test('Task created successfully', () async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final task = Task(id: 3, userId: 1, title: 'Do another test', completed: 0);

    final response = await repo.addNewTask(task);

    expect(response, true);
  });

  test('Remote Tasks Fetched Successfully', () async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final response = await repo.fetchRemoteTasks();

    expect(200, response.length);
  });

  test('Successfully marked as completed', () async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final task = Task(id: 3, userId: 1, title: 'Do another test', completed: 1);
    final response = await repo.updateTask(task);

    expect(response, true);
  });
}
