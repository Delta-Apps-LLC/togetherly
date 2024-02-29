// Model class for the Chore entity

import 'person.dart';

enum ChoreStatus {
  assigned,
  pending,
  completed,
  // Add more statuses as needed
}

class Chore {

  final int _id;
  Person _assignedPerson;
  String _title;
  String _description;
  DateTime _dueDate;
  int _points;
  ChoreStatus _status;
  // later add bool isshared

  Chore(this._id, this._assignedPerson, this._title, this._description,
      this._dueDate, this._points, this._status);

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

  Person get assignedPerson => _assignedPerson;

  set assignedPerson(Person value) {
    _assignedPerson = value;
  }

  int get id => _id;

}
