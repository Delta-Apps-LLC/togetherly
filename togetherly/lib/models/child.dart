import 'person.dart';

class Child extends Person {
  final int totalPoints;

  const Child({
    super.id,
    required super.familyId,
    required super.name,
    required super.icon,
    this.totalPoints = 0,
  });
}
