
extension DateExt on DateTime {
  ///
  /// Checks if date is same as passed date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}