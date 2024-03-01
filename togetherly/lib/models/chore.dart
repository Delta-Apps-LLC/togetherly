// Model class for the Chore entity

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {
  final int? id;
  final int assignedChildId;
  final String title;
  final String description;
  final DateTime dueDate;
  final int points;
  final ChoreStatus status;
  final bool isShared;

  const Chore({
    this.id,
    required this.assignedChildId,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.points,
    this.status = ChoreStatus.assigned,
    required this.isShared,
  });

  // Chore(Chore original, {int? assignedChildId, String? title, String? description,
  //   DateTime? dueDate, int? points, ChoreStatus? status, bool? isShared})
  // : id = original.id,
  //   assignedChildId = assignedChildId ?? original.assignedChildId,
  //   title = title ?? original.title,
  //   description = description ?? original.description,
  //   dueDate = dueDate ?? original.dueDate,
  //   points = points ?? original.points,
  //   status = status ?? original.status,
  //   isShared = isShared ?? original.isShared;
}
