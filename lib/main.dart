import 'package:assessment/bloc/task/task_bloc.dart';
import 'package:assessment/bloc/theme/bloc/theme_bloc.dart';
import 'package:assessment/repository/repo.dart';
import 'package:assessment/routes/router.dart';
import 'package:assessment/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TaskManApp());
}

class TaskManApp extends StatefulWidget {
  const TaskManApp({super.key});

  @override
  State<TaskManApp> createState() => _TaskManAppState();
}

class _TaskManAppState extends State<TaskManApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TaskBloc(TaskRepository()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            initialRoute: HomeScreen.route,
            debugShowCheckedModeBanner: false,
            routes: routes,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
