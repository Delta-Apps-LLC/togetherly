class DateHelpers {
  /// Gets today's date.
  static DateTime getDateToday() => DateTime.now().date;
}

extension DateExtensions on DateTime {
  /// Gets the date component of this DateTime.
  DateTime get date => DateTime(year, month, day);

  /// Returns true if this DateTime has today's date.
  bool isToday() => date == DateHelpers.getDateToday().date;

  /// Returns this DateTime's date as a string in m/d/y format.
  String prettyDate() => "$month/$day/$year";
}
