import 'dart:developer';

import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/base_provider.dart';
import 'package:togetherly/services/chore_service.dart';

class ChoreProvider extends BaseProvider {
  final ChoreService service;

  ChoreProvider(this.service) {
    log("ChoreProvider created!");
    refresh();
  }

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  Iterable<Chore> choresAssignedToPerson(int personId)
    => allChores.where((chore) => chore.assignedChildId == personId);

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

  Future<void> refresh() async {
    _allChores = await service.getChores();
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  //Demo 2
  // Note: This should be implemented as a getter.
  // void sortChoresByDueDate() {
  //
  // }
}
