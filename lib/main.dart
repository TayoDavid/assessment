import 'package:assessment/bloc/task/task_bloc.dart';
import 'package:assessment/bloc/theme/bloc/theme_bloc.dart';
import 'package:assessment/resources/theme/theme_data.dart';
import 'package:assessment/resources/utils/constants.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:assessment/routes/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TaskBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            initialRoute: TaskManApp.route,
            debugShowCheckedModeBanner: false,
            routes: routes,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}

class TaskManApp extends StatelessWidget {
  const TaskManApp({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final icon = state.themeData == lightMode
            ? CupertinoIcons.moon
            : CupertinoIcons.moon_stars_fill;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => toggleTheme(context),
                icon: Icon(icon),
              )
            ],
          ),
          body: PageView(
            children: [],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  bool _toggleCalendarFormat = false;
  CalendarFormat _calenderFormat = CalendarFormat.week;

  double _calendarElevation = 0;

  @override
  void initState() {
    _firstDay = DateTime.now().subtract(Duration(days: 7));
    _lastDay = _firstDay.add(Duration(days: 30));
    _selectedDay = _focusedDay;
    super.initState();
  }

  TextStyle get dayTitleStyle {
    return TextStyle(
      fontSize: 12,
      color: greyTitle,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get dayOfWeekStyle {
    return TextStyle(
      color: green700,
      fontSize: _toggleCalendarFormat ? 14 : 18,
      fontWeight: _toggleCalendarFormat ? FontWeight.w600 : FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Card(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            // padding: _toggleCalendarFormat
            //     ? EdgeInsets.only(left: 12, right: 12, bottom: 12)
            //     : EdgeInsets.zero,
            child: TableCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calenderFormat,
              rowHeight: 44,
              selectedDayPredicate: (day) => day.isSameDay(_selectedDay),
              headerVisible: _toggleCalendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                formatButtonShowsNext: false,
                headerPadding: EdgeInsets.symmetric(vertical: 4),
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  // color: cs.onBackground,
                ),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: cs.onBackground),
                leftChevronIcon:
                    Icon(Icons.chevron_left, color: cs.onBackground),
                formatButtonTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  // color: cs.onBackground,
                ),
                headerMargin: EdgeInsets.symmetric(horizontal: 30),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: dayTitleStyle,
                weekendStyle: dayTitleStyle,
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: dayOfWeekStyle,
                weekendTextStyle: dayOfWeekStyle,
                outsideTextStyle: dayOfWeekStyle,
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.secondary,
                ),
                todayTextStyle: dayOfWeekStyle,
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: _toggleCalendarFormat ? 14 : 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onDaySelected: _onDaySelected,
              onPageChanged: (date) => setState(() {
                _focusedDay = date;
              }),
            ),
          ),
        )
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_selectedDay.isSameDay(selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = _selectedDay;
      });
    }
  }
}
