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
    int? pin,
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
}
