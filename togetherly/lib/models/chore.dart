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
  final Child _assignedChild;
  final String _title;
  final String _description;
  final DateTime _dueDate;
  final int _points;
  final ChoreStatus _status;
  final bool _isShared;

  Chore(this._id, this._assignedChild, this._title, this._description,
      this._dueDate, this._points, this._status, this._isShared);

  ChoreStatus get status => _status;

  int get points => _points;

  DateTime get dueDate => _dueDate;

  String get description => _description;

  String get title => _title;

  Child get assignedPerson => _assignedChild;

  int get id => _id;

  bool get isshared => _isShared;

}
