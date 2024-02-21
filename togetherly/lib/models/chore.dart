// Model class for the Chore entity

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {
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
    this.status = ChoreStatus.assigned,
  });
}
