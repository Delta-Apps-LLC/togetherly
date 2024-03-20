import 'dart:developer';
import 'package:flutter/foundation.dart';

class ScaffoldProvider with ChangeNotifier {
  ScaffoldProvider() {
    log("ScaffoldProvider created");
  }

  int? _index = 2;
  int? get index => _index;

  String? _title = 'Chores';
  String? get title => _title;

  void setNavIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setAppBarTitle(String title) {
    _title = title;
    notifyListeners();
  }
}
