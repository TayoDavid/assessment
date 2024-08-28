import 'package:bloc/bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskBlocInitial()) {
    on<TaskEvent>((event, emit) {
    
    });
  }
}
