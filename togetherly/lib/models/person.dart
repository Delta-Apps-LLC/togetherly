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
}
