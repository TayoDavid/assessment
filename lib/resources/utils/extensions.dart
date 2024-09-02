import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension WidgetExtension on Widget {
  Widget padding({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: bottom, top: top, left: left, right: right),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget get paddingZero {
    return Padding(padding: EdgeInsets.zero, child: this);
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget addSpace({double x = 0, double y = 0}) {
    return SizedBox(width: x, height: y);
  }

  Widget replace(Widget widget, bool when) {
    return when ? widget : this;
  }

  Widget hideIf(bool when) {
    return when ? const SizedBox() : this;
  }

  Widget get center {
    return Center(child: this);
  }

  Widget get fitted {
    return FittedBox(fit: BoxFit.fill, child: this);
  }

  Widget size(double width, double height) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget width(double width) {
    return SizedBox(width: width, child: this);
  }

  Widget height(double height) {
    return SizedBox(height: height, child: this);
  }

  Widget onTap({VoidCallback? execute}) {
    return GestureDetector(
      onTap: execute,
      child: this,
    );
  }

  Widget align({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned.fill(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: this,
    );
  }
}

extension IntExt on int {
  String get padded {
    if (this < 10) return "0$this";
    return "$this";
  }

  List<int> to(int end) {
    if (this <= end) {
      return [for (int i = this; i <= end; i++) i];
    } else {
      return [for (int i = this; i >= end; i--) i];
    }
  }
}

extension StringExt on String {
  String valueIfEmpty(String value) {
    return isNotEmpty ? this : value;
  }

  String get addPipe {
    if (isNotEmpty) return '$this | ';
    return this;
  }

  String get initial {
    return this[0];
  }

  String get initials {
    final words = split(" ").take(2);
    return words.map((word) => word[0]).join().toUpperCase();
  }

  String get moneyFormat {
    return double.parse(this).toStringAsFixed(2);
  }

  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  /// If special char is required add (?=.*?[!@#&*~])
  bool get isValidPassword {
    if (isEmpty) return false;
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d).{8,}$').hasMatch(this);
  }

  bool get isValidPhone {
    if (isEmpty) return false;
    return length >= 10 && length <= 14;
  }

  bool get isValidAccountNumber {
    if (isEmpty) return false;
    return double.tryParse(this) != null;
  }

  String get capitalize {
    if (length <= 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get capitalizeEachWord {
    final words = split(" ");
    return words.map((word) => word.capitalize).toList().join(" ");
  }

  String get paddedDigit {
    return double.parse(this) < 100 ? "0$this" : this;
  }

  bool get hasNumeric {
    return RegExp(".*[0-9].*").hasMatch(this);
  }

  bool get hasLowerCaseChars {
    return RegExp('.*[a-z].*').hasMatch(this);
  }

  bool get hasUpperCaseChars {
    return RegExp('.*[A-Z].*').hasMatch(this);
  }
}

extension OptionalStringExt on String? {
  String get value {
    return this ?? "";
  }

  String get firstTwoChars {
    if (value.isEmpty) return "";
    if (value.length == 1) return value;
    return value.substring(0, 2);
  }

  String get first {
    if (value.isEmpty) return "";
    return value[0];
  }
}

extension StateExt on State {
  void waitAndExec(VoidCallback callback, {Duration? duration}) {
    Future.delayed(duration ?? Duration(milliseconds: 800), callback);
  }
}

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    }
    return null;
  }
}

/// [DateTime] extensions
extension DateExtensions on DateTime {
  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct 2022"
  String monthDate() {
    DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(this);
  }

  ///
  /// To noon of passed date
  DateTime toNoon() {
    return DateTime(year, month, day, 12, 0, 0);
  }

  /// Check if date is between two dates
  bool isBetween(DateTime d1, DateTime d2) {
    if (d1.isBefore(d2)) {
      return (isSameDay(d1) || isAfter(d1)) && (isSameDay(d2) || isBefore(d2));
    }
    return (isSameDay(d2) || isAfter(d2)) && (isSameDay(d1) || isBefore(d1));
  }

  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct 2022"
  String eventFullDate() {
    DateFormat formatter = DateFormat('EEE, d MMM yyyy');
    return formatter.format(this);
  }

  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct 2022"
  String fullWordedDate() {
    return Jiffy.parseFromDateTime(this).format(pattern: 'EEEE, do MMMM yyyy');
  }

  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct"
  String eventHalfDate() {
    return Jiffy.parseFromDateTime(this).format(pattern: 'EEE, do MMM');
  }

  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct"
  String cardDate() {
    DateFormat formatter = DateFormat('EEE, dd MMMM');
    return formatter.format(this);
  }

  ///
  /// [DateTime] Extension for formatting date as "Mon, 26 Oct"
  String formattedDate() {
    DateFormat formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(this);
  }

  ///
  /// [DateTime] Extension for formatting date as "Monday, 26 Oct"
  String fullDateMinusYear() {
    DateFormat formatter = DateFormat('EEEE, d MMMM');
    return formatter.format(this);
  }

  ///
  /// [DateTime] Extension for formatting date as "26 October"
  String dayAndFullMonth() {
    DateFormat formatter = DateFormat('d MMMM');
    return formatter.format(this);
  }

  ///
  /// Checks if date is current day
  bool isCurrentDay() {
    final today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }

  ///
  /// Checks if the passed date is in the current week.
  bool dateIsInCurrentWeek() {
    DateTime now = DateTime.now();
    var firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    var lastDayOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

    if (day == now.day ||
        day == firstDayOfWeek.day ||
        day == lastDayOfWeek.day ||
        (isAfter(firstDayOfWeek) && isBefore(lastDayOfWeek))) {
      return true;
    }
    return false;
  }

  ///
  /// Checks if date is same as passed date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime fromOffset(int hour) {
    return hour > 1
        ? add(Duration(hours: hour))
        : subtract(Duration(hours: hour.abs()));
  }

  ///
  /// Checks if date is same as passed date
  bool isBeforeToday() {
    final stringOther = DateFormat("yyyy-MM-dd").format(this);
    final stringToday = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final otherDate = DateTime.parse(stringOther);
    final todayDate = DateTime.parse(stringToday);

    return todayDate.difference(otherDate).inDays > 0;
  }

  ///
  /// Checks if date is same as passed date
  bool isAfterToday() {
    final stringOther = DateFormat("yyyy-MM-dd").format(this);
    final stringToday = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final otherDate = DateTime.parse(stringOther);
    final todayDate = DateTime.parse(stringToday);

    return otherDate.difference(todayDate).inDays > 0;
  }

  ///
  /// Checks if the passed date is before current month.
  bool isBeforeCurrentMonth() {
    DateTime now = DateTime.now();
    DateTime earlier = now.subtract(Duration(days: now.day));
    return isBefore(earlier);
  }

  ///
  /// Returns Days in word from passed date
  List<String> getDaysInWordsForMonth() {
    var followingMonth = DateTime(year, month + 1, day);
    var numberOfDaysInMonth = followingMonth.difference(this).inDays;

    var dates = List.generate(
      numberOfDaysInMonth,
      (i) => DateFormat('E').format(DateTime(year, month, i + 1)),
    );

    return dates;
  }

  DateTime withTimeOfDay(TimeOfDay time) {
    return DateTime(
      year,
      month,
      day,
      time.hour,
      time.minute,
    );
  }

  ///
  /// Returns Relative duration from current date.
  String timeAgo() {
    final dateYear = year;
    final dateMonth = month;
    final dateDay = day;
    final dateHour = hour;

    final currentDate = DateTime.now();
    final currentYear = currentDate.year;
    final currentMonth = currentDate.month;
    final currentDay = currentDate.day;
    final currentHour = currentDate.hour;

    String count = '';

    if (dateYear < currentYear) {
      count = currentYear - dateYear == 1
          ? "a year"
          : "${currentYear - dateYear} years";
    } else if (dateMonth < currentMonth) {
      count = currentMonth - dateMonth == 1
          ? "a month"
          : "${currentMonth - dateMonth} months";
    } else if (dateDay < currentDay) {
      count =
          currentDay - dateDay == 1 ? "a day" : "${currentDay - dateDay} days";
    } else if (dateHour < currentHour) {
      count = currentHour - dateHour == 1
          ? "an hour"
          : "${currentHour - dateHour} hours";
    } else {
      count = "a moment";
    }

    return "$count ago";
  }

  String pickerFormat() => DateFormat("MMMM dd, yyyy").format(this);

  DateTime ownDateTimeFromOffset(int coachOffset, int ownOffset) {
    final ownDateTimeToUtc = toUtc();
    DateTime toReturn;
    if (coachOffset < ownOffset) {
      toReturn = ownDateTimeToUtc.add(Duration(hours: ownOffset - coachOffset));
    } else {
      toReturn =
          ownDateTimeToUtc.subtract(Duration(hours: coachOffset - ownOffset));
    }
    return toReturn.toLocal();
  }

  DateTime dateTimeFromOffset(int offset) {
    final ownDateTimeToUtc = toUtc();
    if (offset < 0) {
      return ownDateTimeToUtc.subtract(Duration(hours: offset.abs()));
    }
    return ownDateTimeToUtc.add(Duration(hours: offset.abs()));
  }

  String get timezoneWithOffsets {
    final offset = timeZoneOffset.inHours;
    final zone = timeZoneName;
    return "$zone (GMT${offset < 0 ? offset : '+$offset'})";
  }

  String get time {
    DateFormat timeFormat = DateFormat("h:mm a");
    return timeFormat.format(this);
  }

  String get weekdayWord {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }

  DateTime copyTimeFromDate(DateTime otherDate) {
    return copyWith(
        hour: otherDate.hour,
        minute: otherDate.minute,
        second: otherDate.second);
  }

  String get partDate {
    return Jiffy.parseFromDateTime(this).format(pattern: 'do MMM');
  }

  String get partDayMonthYear {
    return Jiffy.parseFromDateTime(this).format(pattern: 'do MMM, yyyy');
  }

  String get dayMonthYear {
    return Jiffy.parseFromDateTime(this).format(pattern: 'dd MMMM, yyyy');
  }

  String get fullDate {
    return Jiffy.parseFromDateTime(this).format(pattern: 'do MMM yyyy h:mm a');
  }

  String get groupedDate {
    if (isCurrentDay()) {
      return "Today";
    }
    if (DateTime.now().difference(this).inDays == 1) {
      return "Yesterday";
    }
    return partDate;
  }

  String get dashDate => DateFormat("d - MM - yyyy").format(this);

  String get dashDateReverse => DateFormat("yyyy - MM - d").format(this);

  String get pdfDate {
    return Jiffy.parseFromDateTime(this).format(pattern: 'MMM dd, yyyy');
  }

  String get pdfTime {
    return Jiffy.parseFromDateTime(this).format(pattern: 'h:mm a');
  }
}

extension ContextExt on BuildContext {
  bool get keyboardVisible {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }
}

extension DynamicExt on dynamic {
  String get strigify {
    return "$this";
  }
}

extension FileExt on File {
  String get name {
    final extension = path.split(".").last;
    var name = path.substring(path.lastIndexOf(r"/") + 1);
    return name.replaceRange(
        name.lastIndexOf(r"."), name.length, ".$extension");
  }
}

extension VoidCallbackExt on VoidCallback {
  VoidCallback get withHaptic {
    return () => {HapticFeedback.lightImpact(), this()};
  }
}
