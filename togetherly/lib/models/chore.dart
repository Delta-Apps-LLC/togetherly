// Model class for the Chore entity

import 'package:togetherly/utilities/value.dart';

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int points;
  final ChoreStatus status;
  final bool isShared;

  const Chore({
    this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.points,
    this.status = ChoreStatus.assigned,
    required this.isShared,
  });

  Chore copyWith({
    Value<int?>? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? points,
    ChoreStatus? status,
    bool? isShared,
  }) =>
      Chore(
        id: (id ?? Value(this.id)).value,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        points: points ?? this.points,
        status: status ?? this.status,
        isShared: isShared ?? this.isShared,
      );

  @override
  String toString() =>
      'Chore(id: $id, title: "$title", description: "$description", dueDate: $dueDate, points: $points, isShared: $isShared)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chore &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          dueDate == other.dueDate &&
          points == other.points &&
          status == other.status &&
          isShared == other.isShared;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      dueDate.hashCode ^
      points.hashCode ^
      status.hashCode ^
      isShared.hashCode;
}
