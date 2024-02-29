
class Reward {

  final int _id;
  String _title;
  String _description;
  int _points;
  bool _isRedeemed;

  Reward(
      this._id, this._title, this._description, this._points, this._isRedeemed);

  bool get isRedeemed => _isRedeemed;

  set isRedeemed(bool value) {
    _isRedeemed = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;
}