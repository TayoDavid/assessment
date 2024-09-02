import 'package:assessment/data/enums/task_option.dart';
import 'package:assessment/data/model/task.dart';
import 'package:assessment/repository/repo.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  TaskBloc(this.repository) : super(TaskBlocInitial()) {
    on<TaskEvent>((event, emit) => event.handle(this, emit));
  }
}
