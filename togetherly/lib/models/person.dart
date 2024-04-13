enum ProfileIcon {
  bear,
  cat,
  chicken,
  dog,
  fish,
  fox,
  giraffe,
  gorilla,
  koala,
  panda,
  rabbit,
  tiger,
}

abstract class Person {
  final int? id;
  final int familyId;
  final String pin;
  final String name;
  final ProfileIcon icon;

  const Person({
    this.id,
    required this.familyId,
    required this.pin,
    required this.name,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          familyId == other.familyId &&
          pin == other.pin &&
          name == other.name &&
          icon == other.icon;

  @override
  int get hashCode =>
      id.hashCode ^
      familyId.hashCode ^
      pin.hashCode ^
      name.hashCode ^
      icon.hashCode;
}
