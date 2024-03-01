import 'person.dart';

class Child extends Person {

    int _totalPoints;

  Child(super.id, super.familyId, super.name, super.icon, this._totalPoints);

    int get totalPoints => _totalPoints;

  set totalPoints(int value) {
    _totalPoints = value;
  }
}