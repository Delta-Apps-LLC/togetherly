import 'dart:core';
import 'package:togetherly/utilities/value.dart';

class ChoreCompletion {
  final int? id;
  final int choreId;
  final int childId;
  final DateTime dateSubmitted;
  final DateTime dueDate;
  final bool isApproved;

  const ChoreCompletion({
    this.id,
    required this.choreId,
    required this.childId,
    required this.dateSubmitted,
    required this.dueDate,
    required this.isApproved,
  });

  ChoreCompletion copyWith({
    Value<int?>? id,
    int? choreId,
    int? childId,
    DateTime? dateSubmitted,
    DateTime? dueDate,
    bool? isApproved,
  }) =>
      ChoreCompletion(
        id: (id ?? Value(this.id)).value,
        choreId: choreId ?? this.choreId,
        childId: childId ?? this.childId,
        dateSubmitted: dateSubmitted ?? this.dateSubmitted,
        dueDate: dueDate ?? this.dueDate,
        isApproved: isApproved ?? this.isApproved,
      );

  @override
  String toString() =>
      'ChoreCompletion(id: $id, choreId: $choreId, childId: $childId, dateSubmitted: $dateSubmitted, dueDate: $dueDate, isApproved: $isApproved)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoreCompletion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          choreId == other.choreId &&
          childId == other.childId &&
          dateSubmitted == other.dateSubmitted &&
          dueDate == other.dueDate &&
          isApproved == other.isApproved;

  @override
  int get hashCode =>
      id.hashCode ^
      choreId.hashCode ^
      childId.hashCode ^
      dateSubmitted.hashCode ^
      dueDate.hashCode ^
      isApproved.hashCode;
}