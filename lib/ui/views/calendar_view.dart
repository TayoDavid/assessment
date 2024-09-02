import 'package:assessment/resources/utils/constants.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView(
      {super.key, required this.onDaySelected, this.selectedDate});

  final DateTime? selectedDate;

  final Function(DateTime) onDaySelected;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  final CalendarFormat _calenderFormat = CalendarFormat.week;

  @override
  void initState() {
    _firstDay = DateTime.now().subtract(Duration(days: 7));
    _lastDay = _firstDay.add(Duration(days: 30));
    _selectedDay = widget.selectedDate ?? _focusedDay;
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
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        TableCalendar(
          firstDay: _firstDay,
          lastDay: _lastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calenderFormat,
          selectedDayPredicate: (day) => day.isSameDay(_selectedDay),
          headerVisible: false,
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
            rightChevronIcon: Icon(Icons.chevron_right, color: cs.onBackground),
            leftChevronIcon: Icon(Icons.chevron_left, color: cs.onBackground),
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
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          onDaySelected: _onDaySelected,
          onPageChanged: (date) => setState(() {
            _focusedDay = date;
          }),
        ),
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_selectedDay.isSameDay(selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = _selectedDay;
      });
      widget.onDaySelected(selectedDay);
    }
  }
}
