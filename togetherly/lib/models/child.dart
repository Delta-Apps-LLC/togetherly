import 'package:togetherly/utilities/value.dart';

import 'person.dart';

class Child extends Person {
  final int totalPoints;

  const Child({
    super.id,
    required super.familyId,
    required super.pin,
    required super.name,
    required super.icon,
    this.totalPoints = 0,
  });

  Child copyWith({
    Value<int?>? id,
    int? familyId,
    String? pin,
    String? name,
    ProfileIcon? icon,
    int? totalPoints,
  }) =>
      Child(
        id: (id ?? Value(this.id)).value,
        familyId: familyId ?? this.familyId,
        pin: pin ?? this.pin,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        totalPoints: totalPoints ?? this.totalPoints,
      );
}
