
enum profileIcon {
  PANDA,
  BEAR,
}

class Person {
  final int _id;
  final int _familyId;
  final String _name;
  final bool _isParent;
  profileIcon _icon;

  Person(
    this._id,
    this._familyId,
    this._name,
    this._isParent,
    this._icon
  );

  bool get isParent => _isParent;

  String get name => _name;

  int get familyId => _familyId;

  int get id => _id;

  profileIcon get icon => _icon;
}


