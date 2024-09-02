import 'package:assessment/bloc/task/task_bloc.dart';
import 'package:assessment/bloc/theme/bloc/theme_bloc.dart';
import 'package:assessment/data/enums/task_option.dart';
import 'package:assessment/data/model/task.dart';
import 'package:assessment/resources/theme/theme_data.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:assessment/resources/utils/functions.dart';
import 'package:assessment/ui/add_task.dart';
import 'package:assessment/ui/views/app_loader.dart';
import 'package:assessment/ui/views/app_text.dart';
import 'package:assessment/ui/views/calendar_view.dart';
import 'package:assessment/ui/views/tab_options.dart';
import 'package:assessment/ui/views/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskBloc _taskBloc;
  TaskOption _selectedTab = TaskOption.all;
  DateTime? _selectedDate;

  @override
  void initState() {
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add(FetchTasksEvent());
    // waitAndExec(2000, () => );
    _fetchRemoteTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final icon = state.themeData == lightMode
            ? CupertinoIcons.moon
            : CupertinoIcons.moon_stars_fill;
        return Scaffold(
          appBar: AppBar(
            title: AppText('TastMan', weight: FontWeight.w600),
            actions: [
              IconButton(
                onPressed: () => toggleTheme(context),
                icon: Icon(icon),
                color: cs.onBackground,
              )
            ],
          ),
          body: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              final tasks = state.stateProps.tasks;
              if (state is TaskDeletedSuccessfully) {
                showMessage(context, "Task deleted successfully!");
              }

              if (tasks.isEmpty && state is LoadingTasks) {
                Loader.show(context);
              } else {
                Loader.dismiss(context);
              }
            },
            builder: (context, state) {
              final allTasks = state.stateProps.filteredTasks;
              String message = 'No ${_selectedTab.title} task';
              if (_selectedDate != null) {
                message += ' for ${_selectedDate!.partDate}';
              }
              return Column(
                children: [
                  ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      for (var option in TaskOption.values) ...[
                        TabOptions(
                          option: option,
                          selected: option == _selectedTab,
                          onSelected: () => onTabItemSelected(option),
                        )
                      ]
                    ],
                  ).size(size.width, 32),
                  SizedBox(height: 20),
                  CalendarView(onDaySelected: _onDaySelected)
                      .paddingSymmetric(horizontal: 8),
                  if (allTasks.isEmpty) ...[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/empty.png',
                            width: 128,
                            height: 128,
                            color: cs.onBackground,
                          ).padding(top: 100),
                          AppText(message).padding(top: 32)
                        ],
                      ),
                    )
                  ] else ...[
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final task = allTasks[index];
                          return TaskItem(
                            task: task,
                            onDoneTapped: () => _markAsDone(task),
                            onEditTapped: () => _editTask(task),
                            onDeleteTapped: () => _deleteTask(task),
                          );
                        },
                        separatorBuilder: (ctx, index) =>
                            Divider(color: cs.surface, height: 1, thickness: 1),
                        itemCount: allTasks.length,
                      ).paddingSymmetric(horizontal: 8),
                    )
                  ],
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _addNewTask,
            child: Icon(CupertinoIcons.add),
          ),
        );
      },
    );
  }

  void toggleTheme(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final currentTheme = themeBloc.state.themeData;
    final mode =
        currentTheme == lightMode ? AppThemeMode.dark : AppThemeMode.light;
    themeBloc.add(ToggleTheme(mode));
  }

  void _addNewTask() {
    Navigator.pushNamed(
      context,
      AddTaskScreen.route,
      arguments: {'isEdit': false},
    );
  }

  _onDaySelected(DateTime date) {
    setState(() => _selectedDate = date);
    _taskBloc.add(FilterByDate(_selectedDate!));
  }

  void _markAsDone(Task task) {
    if (task.completed == 1) {
      task.completed = 0;
    } else {
      task.completed = 1;
    }
    _taskBloc.add(ToggleCompletion(task));
  }

  void _deleteTask(Task task) {
    _taskBloc.add(DeleteTask(task));
  }

  void _editTask(Task task) {
    Navigator.pushNamed(
      context,
      AddTaskScreen.route,
      arguments: {'isEdit': true, 'task': task},
    );
  }

  onTabItemSelected(TaskOption option) {
    setState(() {
      _selectedTab = option;
      _selectedDate = null;
    });
    _taskBloc.add(FilterTaskBy(option));
  }

  void _fetchRemoteTasks() {
    _taskBloc.add(FetchRemoteTasksEvent());
  }
}
