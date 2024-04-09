import 'package:togetherly/utilities/value.dart';

class Reward {
  final int? id;
  final String title;
  final String description;
  final int points;
  final int quantity;

  const Reward({
    this.id,
    required this.title,
    this.description = '',
    required this.points,
    required this.quantity,
  });

  Reward copyWith({
    Value<int?>? id,
    String? title,
    String? description,
    int? points,
    int? quantity,
  }) =>
      Reward(
        id: (id ?? Value(this.id)).value,
        title: title ?? this.title,
        description: description ?? this.description,
        points: points ?? this.points,
        quantity: quantity ?? this.quantity,
      );

  @override
  String toString() =>
      'Reward(id: $id, title: "$title", description: "$description", points: $points, quantity: $quantity)';
}
