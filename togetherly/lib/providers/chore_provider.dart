import 'dart:developer';

import 'package:togetherly/providers/base_provider.dart';
import 'package:togetherly/services/example_service.dart';

import '../models/chore.dart';
import '../services/chore_service.dart';

class ChoreProvider extends BaseProvider {
  final ChoreService service;

  //TODO Is this where we need to initialize the list?
  ChoreProvider(this.service, this._personId) {
    log("ExampleProvider created!");
    refresh();
  }

  List<Chore> _choreList = [];
  List<Chore> get choreList => _choreList;
  int _personId;
  int get personId => _personId;

  Future<void> addChore(Chore chore) async {
    await service.addChore(chore);
    notifyListeners();
  }

  Future<void> deleteChore(Chore chore) async {
    await service.deleteChore(chore);
    notifyListeners();
  }

  Future<void> updateChore(Chore chore) async {
    await service.addChore(chore);
    notifyListeners();
  }

  //TODO: make sure you are doing the personId correctly
  @override
  Future<void> refresh() async {
    //Can we have a variable passed in for this function? If so,
    _choreList = await service.getChoreList(this._personId);
    notifyListeners();
    log("ExampleProvider refreshed!");
  }

  //Demo 2
  void sortChoresByDueDate() {

  }
}