
import 'package:togetherly/models/parent.dart';
import 'child.dart';

class Family {

  final int _id;
  String _name;
  List<Parent> _parents;
  List<Child> _children;

  Family(this._id, this._name, this._parents, this._children);
}