enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Assignment {
  final int? personId;
  final int? choreId;
  final ChoreStatus status;

  const Assignment({
    required this.personId,
    required this.choreId,
    this.status = ChoreStatus.assigned,
  });

  Assignment copyWith({
    int? personId,
    int? choreId,
    ChoreStatus? status,
  }) =>
      Assignment(
          personId: personId ?? this.personId,
          choreId: choreId ?? this.choreId,
          status: status ?? this.status,
      );
}