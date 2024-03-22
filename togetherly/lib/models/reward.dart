import 'package:togetherly/utilities/value.dart';

class Reward {
  final int? id;
  final String title;
  final String description;
  final int points;
  final int quantity;
  final int familyId;

  const Reward({
    this.id,
    required this.title,
    this.description = '',
    required this.points,
    required this.quantity,
    required this.familyId,
  });

  Reward copyWith({
    Value<int?>? id,
    String? title,
    String? description,
    int? points,
    int? quantity,
    int? familyId,
  }) =>
      Reward(
        id: (id ?? Value(this.id)).value,
        title: title ?? this.title,
        description: description ?? this.description,
        points: points ?? this.points,
        quantity: quantity ?? this.quantity,
        familyId: familyId ?? this.familyId,
      );
}
