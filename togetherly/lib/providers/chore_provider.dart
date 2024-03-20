import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/chore_service.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(this._service, this._userIdentityProvider) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService _service;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  // Iterable<Chore> choresAssignedToPerson(int personId)
  //   => allChores.where((chore) => chore.assignedChildId == personId);

  // Iterable<Chore>? get choresAssignedToCurrentUser {
  //   int? personId = _userIdentityProvider.personId;
  //   return personId == null ? null : choresAssignedToPerson(personId);
  // }

  Future<void> addChore(Chore chore) async {
    await _service.insertChore(chore);
    await refresh();
  }

  Future<void> deleteChore(Chore chore) async {
    await _service.deleteChore(chore);
    await refresh();
  }

  Future<void> updateChore(Chore chore) async {
    await _service.updateChore(chore);
    await refresh();
  }

  //Demo 2
  // Note: This should be implemented as a getter.
  // void sortChoresByDueDate() {
  //
  // }

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _allChores = await _service.getChores(familyId);
    } else {
      _allChores = [];
    }
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
