import 'dart:developer';

import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/base_provider.dart';
import 'package:togetherly/services/chore_service.dart';

class ChoreProvider extends BaseProvider {
  final ChoreService service;
  final int personId;

  ChoreProvider(this.service, this.personId) {
    log("ChoreProvider created!");
    refresh();
  }

  List<Chore> _choreList = [];
  List<Chore> get choreList => _choreList;

  Future<void> addChore(Chore chore) async {
    await service.insertChore(chore);
    await refresh();
  }

  Future<void> deleteChore(Chore chore) async {
    await service.deleteChore(chore);
    await refresh();
  }

  Future<void> updateChore(Chore chore) async {
    await service.updateChore(chore);
    await refresh();
  }

  @override
  Future<void> refresh() async {
    //Can we have a variable passed in for this function? If so,
    // _choreList = await service.getChoreList(personId);
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  //Demo 2
  // Note: This should be implemented as a getter.
  // void sortChoresByDueDate() {
  //
  // }
}
