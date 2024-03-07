import 'dart:developer';
import 'package:togetherly/providers/base_provider.dart';

class ScaffoldProvider extends BaseProvider {
  ScaffoldProvider() {
    log("ScaffoldProvider created!");
  }

  int? _index = 0;
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
