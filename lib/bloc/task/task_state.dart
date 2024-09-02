part of 'task_bloc.dart';

class TaskStateProps {
  final List<Task> tasks;
  final List<Task> filteredTasks;

  TaskStateProps({required this.tasks, required this.filteredTasks});

  TaskStateProps copyWith({List<Task>? allTasks, List<Task>? filteredTks}) {
    return TaskStateProps(
      tasks: allTasks ?? tasks,
      filteredTasks: filteredTks ?? filteredTasks,
    );
  }
}

sealed class TaskState {
  final TaskStateProps stateProps;

  TaskState({required this.stateProps});
}

final class TaskBlocInitial extends TaskState {
  TaskBlocInitial()
      : super(stateProps: TaskStateProps(tasks: [], filteredTasks: []));
}

final class LoadingTasks extends TaskState {
  final TaskStateProps taskProps;

  LoadingTasks(this.taskProps) : super(stateProps: taskProps);
}

final class TasksLoaded extends TaskState {
  final TaskStateProps taskProps;

  TasksLoaded(this.taskProps) : super(stateProps: taskProps);
}

final class AddingOrUpdatingTask extends TaskState {
  final TaskStateProps taskProps;

  AddingOrUpdatingTask(this.taskProps) : super(stateProps: taskProps);
}

final class DeletingTask extends TaskState {
  final TaskStateProps taskProps;

  DeletingTask(this.taskProps) : super(stateProps: taskProps);
}

final class TaskDeletedSuccessfully extends TaskState {
  final TaskStateProps taskProps;

  TaskDeletedSuccessfully(this.taskProps) : super(stateProps: taskProps);
}

final class AddedOrUpdatedTaskSuccessfully extends TaskState {
  final TaskStateProps taskProps;

  AddedOrUpdatedTaskSuccessfully(this.taskProps) : super(stateProps: taskProps);
}

final class FilteringTask extends TaskState {
  final TaskStateProps taskProps;

  FilteringTask(this.taskProps) : super(stateProps: taskProps);
}

final class FilterTaskSuccessful extends TaskState {
  final TaskStateProps taskProps;

  FilterTaskSuccessful(this.taskProps) : super(stateProps: taskProps);
}

final class TaskError extends TaskState {
  final TaskStateProps taskProps;
  final String errMsg;

  TaskError(this.taskProps, this.errMsg) : super(stateProps: taskProps);
}
