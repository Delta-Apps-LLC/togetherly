

import 'person.dart';

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {
  final int id; //TODO set to auto increment in the database
  final Person assignedPerson;
  final String title;
  final DateTime dueDate;
  final int points;
  final ChoreStatus status;
  final bool isBonus;
  // Add other properties as needed
  const Chore({
    required this.title,
    required this.dueDate,
    required this.points,
    required this.isBonus,
    required this.assignedPerson,
    this.status = ChoreStatus.ASSIGNED,
    this.id = 0 //TODO FIX!
  });
}