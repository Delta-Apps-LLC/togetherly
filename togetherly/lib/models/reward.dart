import 'package:togetherly/utilities/value.dart';

class Reward {

  final int? id;
  final String title;
  final String description;
  final int points;
  final bool isRedeemed;

  const Reward ({
    this.id,
    required this.title,
    this.description = '',
    required this.points,
    required this.isRedeemed,
});

  Reward copyWith({
    Value<int?>? id,
    String? title,
    String? description,
    int? points,
    bool? isRedeemed,
  }) =>
      Reward(
        id: (id ?? Value(this.id)).value,
        title: title ?? this.title,
        description: description ?? this.description,
        points: points ?? this.points,
        isRedeemed: isRedeemed ?? this.isRedeemed,
      );


}