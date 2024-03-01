import 'package:togetherly/models/person.dart';

class Parent extends Person {
  const Parent({
    super.id,
    required super.familyId,
    required super.name,
    required super.icon,
  });
}
