class DateHelpers {
  DateTime getDateToday() {
    DateTime date = DateTime.now();
    return DateTime(date.year, date.month, date.day);
  }

  bool isDueToday(DateTime dueDate) {
    return dueDate.toString().split(' ')[0] == getDateToday().toString();
  }

  String prettyDate(DateTime dueDate) {
    return "${dueDate.month}/${dueDate.day}/${dueDate.year}";
  }
}
