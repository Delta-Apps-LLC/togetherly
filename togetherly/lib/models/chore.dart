// Model class for the Chore entity

import 'child.dart';

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {

  final int _id;
  Child _assignedChild;
  String _title;
  String _description;
  DateTime _dueDate;
  int _points;
  ChoreStatus _status;
  bool _isShared;

  Chore(this._id, this._assignedChild, this._title, this._description,
      this._dueDate, this._points, this._status, this._isShared);

  ChoreStatus get status => _status;

  set status(ChoreStatus value) {
    _status = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  DateTime get dueDate => _dueDate;

  set dueDate(DateTime value) {
    _dueDate = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  Child get assignedPerson => _assignedChild;

  set assignedChild(Child value) {
    _assignedChild = value;
  }

  int get id => _id;

  bool get isshared => _isShared;

  set isshared(bool value) {
    _isShared = value;
  }
}
