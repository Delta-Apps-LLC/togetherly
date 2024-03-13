import 'dart:developer';
import 'package:togetherly/providers/base_provider.dart';

enum HomePageType { parent, child }

class ScaffoldProvider extends BaseProvider {
  ScaffoldProvider() {
    log("ScaffoldProvider created!");
    refresh();
  }

  int? _index = 0;
  int? get index => _index;

  String? _title = 'Family'; // TODO: change default title
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
