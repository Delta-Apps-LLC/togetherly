import 'dart:developer';

import 'package:togetherly/providers/base_provider.dart';
import 'package:togetherly/services/scaffold_service.dart';

class ScaffoldProvider extends BaseProvider {
  final ScaffoldService service;

  ScaffoldProvider(this.service) {
    log("ScaffoldProvider created!");
    refresh();
  }

  int? _index;
  int? get index => _index;

  String? _title;
  String? get title => _title;

  Future<void> setNavIndex(int index) async {
    await service.setNavIndex(index);
    _index = index;
    notifyListeners();
  }

  Future<void> setAppBarTitle(String title) async {
    await service.setAppBarTitle(title);
    _title = title;
    notifyListeners();
  }

  @override
  Future<void> refresh() async {
    _index = await service.getNavIndex();
    _title = await service.getAppBarTitle();
    notifyListeners();
    log("ScaffoldProvider refreshed!");
  }
}
