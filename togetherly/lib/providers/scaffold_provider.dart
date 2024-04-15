import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';

enum HomePageType { parent, child }

class ScaffoldProvider with ChangeNotifier {
  ScaffoldProvider(this._userIdentityProvider, this._personProvider) {
    log("ScaffoldProvider created");
  }

  UserIdentityProvider _userIdentityProvider;
  PersonProvider _personProvider;

  int? _index = 0;
  int? get index => _index;

  String? _title =
      'Family'; // TODO: change default title depending on isParent ? (family name) : (child name)
  String? get title => _title;

  HomePageType? _homePageType;
  HomePageType get homePageType => _personProvider.currentChild != null
      ? HomePageType.child
      : _childBeingViewed != null && _personProvider.currentParent != null
          ? HomePageType.child
          : HomePageType.parent;

  Child? _childBeingViewed;
  Child? get childBeingViewed => _childBeingViewed;

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

  void setChildBeingViewed(Child childBeingViewed) {
    _childBeingViewed = childBeingViewed;
    notifyListeners();
  }

  void setScaffoldValues(
      {int? index,
      String? title,
      HomePageType? type,
      Child? childBeingViewed}) {
    _index = index ?? _index;
    _title = title ?? _title;
    _homePageType = type ?? _homePageType;
    _childBeingViewed = childBeingViewed;
    notifyListeners();
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider,
      PersonProvider personProvider) {
    _userIdentityProvider = userIdentityProvider;
    _personProvider = personProvider;
  }
}
