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
  String toString() => {
        'id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate,
        'points': points,
        'status': status,
        'isShared': isShared,
      }.toString();
}
