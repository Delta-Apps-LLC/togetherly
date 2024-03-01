enum profileIcon {
  PANDA,
  BEAR,
}

//Database table will include totalPoints and isParent

abstract class Person {
  final int _id;
  final int _familyId;
  final String _name;
  profileIcon _icon;

  Person(
      this._id,
      this._familyId,
      this._name,
      this._icon,
      );

  String get name => _name;

  int get familyId => _familyId;

  int get id => _id;

  profileIcon get icon => _icon;
}
