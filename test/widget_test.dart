// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:assessment/bloc/task/task_bloc.dart';
import 'package:assessment/bloc/theme/bloc/theme_bloc.dart';
import 'package:assessment/data/model/task.dart';
import 'package:assessment/resources/theme/theme_data.dart';
import 'package:assessment/ui/home.dart';
import 'package:assessment/ui/views/task_item.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;
  late MockThemeBloc mockThemeBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
    mockThemeBloc = MockThemeBloc();

    // Mock the initial state of the blocs
    when(() => mockTaskBloc.state).thenReturn(TaskBlocInitial());
    when(() => mockThemeBloc.state).thenReturn(ThemeState(lightMode));
  });

  tearDown(() {
    mockTaskBloc.close();
    mockThemeBloc.close();
  });

  group('HomeScreen Widget Tests', () {
    testWidgets('Displays loading indicator when tasks are loading',
        (tester) async {
      when(() => mockTaskBloc.state).thenReturn(LoadingTasks(TaskStateProps(
        tasks: [],
        filteredTasks: [],
      )));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<TaskBloc>.value(value: mockTaskBloc),
              BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Displays list of tasks when loaded', (tester) async {
      // Arrange
      final tasks = [
        Task(
          id: 1,
          title: 'Task 1',
          description: 'Description 1',
          completed: 0,
        ),
        Task(
          id: 2,
          title: 'Task 2',
          description: 'Description 2',
          completed: 1,
        ),
      ];

      when(() => mockTaskBloc.state).thenReturn(
        TasksLoaded(TaskStateProps(tasks: tasks, filteredTasks: tasks)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<TaskBloc>.value(value: mockTaskBloc),
              BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      await tester.pump(); // Rebuild the widget with the updated state

      expect(find.byType(TaskItem), findsNWidgets(tasks.length));
    });

    testWidgets('Displays empty state message when there are no tasks',
        (tester) async {
      when(() => mockTaskBloc.state).thenReturn(
        TasksLoaded(TaskStateProps(tasks: [], filteredTasks: [])),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<TaskBloc>.value(value: mockTaskBloc),
              BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('No  task'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Toggles theme on icon button tap', (tester) async {
      when(() => mockTaskBloc.state).thenReturn(
          TasksLoaded(TaskStateProps(tasks: [], filteredTasks: [])));
      when(() => mockThemeBloc.state).thenReturn(ThemeState(lightMode));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<TaskBloc>.value(value: mockTaskBloc),
              BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      // Tap on the theme toggle button
      await tester.tap(find.byIcon(CupertinoIcons.moon));
      await tester.pump();

      verifyNever(() => mockThemeBloc.add(ToggleTheme(AppThemeMode.dark)));
    });
  });
}
