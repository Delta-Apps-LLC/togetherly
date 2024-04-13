import 'dart:core';
import 'package:togetherly/utilities/value.dart';

class RewardRedemption {
  final int? id;
  final int rewardId;
  final int childId;
  final int quantity;
  final DateTime timestamp;

  const RewardRedemption({
    this.id,
    required this.rewardId,
    required this.childId,
    required this.quantity,
    required this.timestamp,
  });

  RewardRedemption copyWith({
    Value<int?>? id,
    int? rewardId,
    int? childId,
    int? quantity,
    DateTime? timestamp,
  }) =>
      RewardRedemption(
        id: (id ?? Value(this.id)).value,
        rewardId: rewardId ?? this.rewardId,
        childId: childId ?? this.childId,
        quantity: quantity ?? this.quantity,
        timestamp: timestamp ?? this.timestamp,
      );

  @override
  String toString() =>
      'RewardRedemption(id: $id, rewardId: $rewardId, childId: $childId, quantity: $quantity, timestamp: $timestamp)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RewardRedemption &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rewardId == other.rewardId &&
          childId == other.childId &&
          quantity == other.quantity &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^
      rewardId.hashCode ^
      childId.hashCode ^
      quantity.hashCode ^
      timestamp.hashCode;
}
