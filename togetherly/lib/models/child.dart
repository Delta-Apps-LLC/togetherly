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

  @override
  String toString() =>
      'Child(id: $id, familyId: $familyId, pin: "${'*' * pin.length}", name: "$name", icon: $icon, totalPoints: $totalPoints)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Child &&
          runtimeType == other.runtimeType &&
          totalPoints == other.totalPoints;

  @override
  int get hashCode => super.hashCode ^ totalPoints.hashCode;
}
