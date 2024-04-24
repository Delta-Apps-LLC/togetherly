import 'package:togetherly/models/chore.dart';
import 'package:togetherly/utilities/date.dart';

extension ChoreIterableExtension on Iterable<Chore> {
  Iterable<Chore> get dueToday => where((chore) => chore.isDueToday);
  Iterable<Chore> get dueTomorrow => where((chore) => chore.isDueTomorrow);
  Iterable<Chore> get overdue => where((chore) => chore.isOverdue);
}

extension ChoreDueDateExtension on Chore {
  bool get isDueToday => dueDate == DateHelpers.getDateToday();

  bool get isDueTomorrow {
    final dateToday = DateHelpers.getDateToday();
    return dueDate.year == dateToday.year &&
        dueDate.month == dateToday.month &&
        dueDate.day == dateToday.day + 1;
  }

  bool get isOverdue {
    final dateToday = DateHelpers.getDateToday();
    if (dueDate.year < dateToday.year) {
      return true;
    } else if (dueDate.year == dateToday.year &&
        dueDate.month < dateToday.month) {
      return true;
    } else if (dueDate.year == dateToday.year &&
        dueDate.month == dateToday.month &&
        dueDate.day < dateToday.day) {
      return true;
    }
    return false;
  }
}
