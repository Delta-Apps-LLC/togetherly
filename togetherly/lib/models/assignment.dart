enum AssignmentStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Assignment {
  final int personId;
  final int choreId;
  final AssignmentStatus status;

  const Assignment({
    required this.personId,
    required this.choreId,
    this.status = AssignmentStatus.assigned,
  });

  Assignment copyWith({
    int? personId,
    int? choreId,
    AssignmentStatus? status,
  }) =>
      Assignment(
        personId: personId ?? this.personId,
        choreId: choreId ?? this.choreId,
        status: status ?? this.status,
      );

  @override
  String toString() =>
      'Assignment(personId: $personId, choreId: $choreId, status: $status)';
}
