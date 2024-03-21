import 'dart:developer';
import 'package:flutter/foundation.dart';

enum HomePageType { parent, child }

class ScaffoldProvider with ChangeNotifier {
  ScaffoldProvider() {
    log("ScaffoldProvider created");
  }

  int? _index = 0;
  int? get index => _index;

  String? _title = 'Family'; // TODO: change default title depending on isParent ? (family name) : (child name)
  String? get title => _title;

  HomePageType _homePageType = HomePageType.parent;
  HomePageType get homePageType => _homePageType;

  void setNavIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setAppBarTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setHomePageType(HomePageType type) {
    _homePageType = type;
    notifyListeners();
  }

  @override
  Future<void> refresh() async {
    notifyListeners();
    log("ScaffoldProvider refreshed!");
  }
}
