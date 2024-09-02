import 'package:assessment/data/db/database_helper.dart';

class Task {
  int? userId;
  int? id;
  String? title;
  String? description;
  int? completed;
  String? dateTime;
  int? duration;
  String? createdDateString;
  String? updatedDateString;

  Task({
    this.userId,
    this.id,
    this.title,
    this.completed,
    this.description,
    this.dateTime,
    this.duration,
    this.createdDateString,
    this.updatedDateString,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      userId: map['userId'],
      id: map['_id'],
      title: map['title'],
      description: map['description'],
      completed: map['completed'],
      dateTime: map['dateTime'],
      duration: map['duration'],
      createdDateString: map['created'],
      updatedDateString: map['updated'],
    );
  }

  factory Task.fromJson(Map<String, dynamic> json, {int offsetIdBy = 0}) {
    return Task(
      userId: json['userId'],
      id: json['id'] + offsetIdBy,
      title: json['title'],
      completed: json['completed'] == true ? 1 : 0,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> task = {};
    if (id != null) {
      task[DatabaseHelper.columnId] = id;
    }
    task[DatabaseHelper.columnUserId] = 1;
    if (title != null) {
      task[DatabaseHelper.columnTitle] = title;
    }
    if (completed != null) {
      task[DatabaseHelper.columnCompleted] = completed;
    }
    if (description != null) {
      task[DatabaseHelper.columnDesc] = description;
    }
    if (dateTime != null) {
      task[DatabaseHelper.columnDateTime] = dateTime;
    }
    if (duration != null) {
      task[DatabaseHelper.columnDuration] = duration;
    }
    if (createdDateString == null) {
      task[DatabaseHelper.columnDateCreated] = DateTime.now().toString();
    }
    if (updatedDateString == null) {
      task[DatabaseHelper.columnDateUpdated] = DateTime.now().toString();
    }
    return task;
  }
}
