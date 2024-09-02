part of 'task_bloc.dart';

sealed class TaskEvent {
  Future<void> handle(TaskBloc bloc, Emitter emit);
}

class ClearTasks extends TaskEvent {
  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    emit(TaskBlocInitial());
  }
}

class FetchTasksEvent extends TaskEvent {
  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(LoadingTasks(props.copyWith(allTasks: [], filteredTks: [])));
      final tasks = await bloc.repository.loadTasksFromDb();
      final newProps = props.copyWith(allTasks: tasks, filteredTks: tasks);
      emit(TasksLoaded(newProps));
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error loading tasks"));
    }
  }
}

class FetchRemoteTasksEvent extends TaskEvent {
  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(LoadingTasks(props));
      final lastId = await bloc.repository.getLastTask();
      if (lastId >= 200) {
        emit(TasksLoaded(props));
        return;
      }

      final tasks = await bloc.repository.fetchRemoteTasks();
      if (tasks.last.id == lastId) {
        emit(TasksLoaded(props));
        return;
      }

      if (tasks.isNotEmpty) {
        await bloc.repository.batchUpdate(tasks);
      }
      final newTasks = [...props.tasks, ...tasks];
      final newProps =
          props.copyWith(allTasks: newTasks, filteredTks: newTasks);
      emit(TasksLoaded(newProps));
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error loading tasks"));
    }
  }
}

class AddNewTasksEvent extends TaskEvent {
  final Task task;
  final bool isEdit;
  AddNewTasksEvent(this.task, {this.isEdit = false});

  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(AddingOrUpdatingTask(props));
      bool response;
      if (isEdit) {
        response = await bloc.repository.updateTask(task);
      } else {
        response = await bloc.repository.addNewTask(task);
      }

      if (response) {
        emit(AddedOrUpdatedTaskSuccessfully(props));
      } else {
        emit(TaskError(props, "Error adding new task"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error adding new task"));
    }
  }
}

class ToggleCompletion extends TaskEvent {
  final Task task;

  ToggleCompletion(this.task);

  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(AddingOrUpdatingTask(props));
      final response = await bloc.repository.updateTask(task);
      if (response) {
        emit(AddedOrUpdatedTaskSuccessfully(props));
      } else {
        emit(TaskError(props, "Error marking task as done"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error marking task as done"));
    }
  }
}

class DeleteTask extends TaskEvent {
  final Task task;

  DeleteTask(this.task);
  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      final taskId = task.id;
      if (taskId == null) return;
      emit(DeletingTask(props));
      final response = await bloc.repository.deleteTaskWhere(taskId);
      if (response) {
        final tasks = List<Task>.from(
          props.filteredTasks
              .where((element) => element.id != task.id)
              .toList(),
        );
        final newProps = props.copyWith(allTasks: tasks, filteredTks: tasks);
        emit(TaskDeletedSuccessfully(newProps));
      } else {
        emit(TaskError(props, "Error deleting task with id: ${task.id}"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error deleting task with id: ${task.id}"));
    }
  }
}

class FilterTaskBy extends TaskEvent {
  final TaskOption option;

  FilterTaskBy(this.option);
  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(FilteringTask(props));
      List<Task> filteredTask = List<Task>.from(props.tasks);
      switch (option) {
        case TaskOption.all:
          filteredTask = List<Task>.from(props.tasks);
        case TaskOption.completed:
          filteredTask.retainWhere((task) => task.completed == 1);
        case TaskOption.uncompleted:
          filteredTask.retainWhere((task) => task.completed != 1);
      }
      final newProps = props.copyWith(filteredTks: filteredTask);
      emit(FilterTaskSuccessful(newProps));
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error filtering ${option.title} tasks."));
    }
  }
}

class FilterByDate extends TaskEvent {
  final DateTime dateTime;

  FilterByDate(this.dateTime);

  @override
  Future<void> handle(TaskBloc bloc, Emitter emit) async {
    final props = bloc.state.stateProps;
    try {
      emit(FilteringTask(props));
      List<Task> filteredTask = List<Task>.from(props.filteredTasks);
      filteredTask.retainWhere((task) {
        DateTime? taskDate = DateTime.tryParse(task.dateTime.value);
        taskDate ??= DateTime.tryParse(task.createdDateString.value);

        if (taskDate == null) return false;
        return taskDate.isSameDay(dateTime);
      });

      final newProps = props.copyWith(filteredTks: filteredTask);
      emit(FilterTaskSuccessful(newProps));
    } catch (e) {
      debugPrint(e.toString());
      emit(TaskError(props, "Error filtering task for ${dateTime.partDate}."));
    }
  }
}
