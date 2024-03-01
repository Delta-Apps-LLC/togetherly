enum profileIcon {
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
  final String name;
  final profileIcon icon;

  const Person({
    this.id,
    required this.familyId,
    required this.name,
    required this.icon,
  });
}
