import 'package:togetherly/utilities/value.dart';

import 'person.dart';

class Child extends Person {
  final int totalPoints;

  const Child({
    super.id,
    required super.familyId,
    required super.name,
    required super.icon,
    required super.isParent,
    this.totalPoints = 0,
  });

  Child copyWith({
    Value<int?>? id,
    int? familyId,
    String? name,
    ProfileIcon? icon,
    bool? isParent,
    int? totalPoints,
  }) =>
      Child(
        id: (id ?? Value(this.id)).value,
        familyId: familyId ?? this.familyId,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        isParent: isParent ?? this.isParent,
        totalPoints: totalPoints ?? this.totalPoints,
      );
}
