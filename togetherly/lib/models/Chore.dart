

class Chore {
  int _id = 0;
  String _name = "";
  DateTime _dayDue = DateTime.now();
  bool _completion = false;
  int _points = 0;


  Chore();


  Chore.name(this._name, this._dayDue, this._completion, this._points);

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  bool get completion => _completion;

  set completion(bool value) {
    _completion = value;
  }

  DateTime get dayDue => _dayDue;

  set dayDue(DateTime value) {
    _dayDue = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}