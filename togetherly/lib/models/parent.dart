import 'package:togetherly/models/person.dart';
import 'package:togetherly/utilities/value.dart';

class Parent extends Person {
  const Parent({
    super.id,
    required super.familyId,
    required super.pin,
    required super.name,
    required super.icon,
  });

  Parent copyWith({
    Value<int?>? id,
    int? familyId,
    String? pin,
    String? name,
    ProfileIcon? icon,
  }) =>
      Parent(
        id: (id ?? Value(this.id)).value,
        familyId: familyId ?? this.familyId,
        pin: pin ?? this.pin,
        name: name ?? this.name,
        icon: icon ?? this.icon,
      );

  @override
  String toString() =>
      'Parent(id: $id, familyId: $familyId, pin: "${'*' * pin.length}", name: "$name", icon: $icon)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is Parent && runtimeType == other.runtimeType;

  // Must override hashCode to get rid of one warning, and must modify the value
  // of super.hashCode in some way to get rid of a different warning.
  @override
  int get hashCode => super.hashCode ^ 1;
}
