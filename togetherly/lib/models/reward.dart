import 'package:togetherly/utilities/value.dart';

class Reward {
  final int? id;
  final String title;
  final String description;
  final int points;
  final int quantity;

  /// Icon represented as a Unicode code point
  final int icon;

  const Reward({
    this.id,
    required this.title,
    this.description = '',
    required this.points,
    required this.quantity,
    required this.icon,
  });

  Reward copyWith({
    Value<int?>? id,
    String? title,
    String? description,
    int? points,
    int? quantity,
    int? icon,
  }) =>
      Reward(
        id: (id ?? Value(this.id)).value,
        title: title ?? this.title,
        description: description ?? this.description,
        points: points ?? this.points,
        quantity: quantity ?? this.quantity,
        icon: icon ?? this.icon,
      );

  @override
  String toString() =>
      'Reward(id: $id, title: "$title", description: "$description", points: $points, quantity: $quantity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reward &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          points == other.points &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      points.hashCode ^
      quantity.hashCode;
}
