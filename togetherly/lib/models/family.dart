
import 'package:togetherly/models/parent.dart';
import 'child.dart';

class Family {

  final int _id;
  final String _name;

  Family(this._id, this._name);

  String get name => _name;

  int get id => _id;
}