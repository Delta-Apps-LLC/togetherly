import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_service.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(this.choreService, this._userIdentityProvider) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService choreService;
  final AssignmentService assignmentService;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  // Iterable<Chore> choresAssignedToPerson(int personId)
  //   => allChores.where((chore) => chore.assignedChildId == personId);

  // Iterable<Chore>? get choresAssignedToCurrentUser {
  //   int? personId = _userIdentityProvider.personId;
  //   return personId == null ? null : choresAssignedToPerson(personId);
  // }

  Future<void> addChore(Chore chore, children) async {
    chore = await choreService.insertChore(chore);
    for (final c in children) {
      Assignment assignment = Assignment(personId: c, choreId: chore.id!);
      await assignmentService.insertAssignment(assignment);
    }
    await refresh();
  }

  Future<void> deleteChore(Chore chore, children) async {
    await choreService.deleteChore(chore);
    for (final c in children) {
      Assignment assignment = Assignment(personId: c, choreId: chore.id!);
      await assignmentService.deleteAssignment(assignment);
    }
    await refresh();
  }

  Future<void> updateChore(Chore chore) async {
    await choreService.updateChore(chore);
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
      _allChores = await choreService.getChoresByFamily(familyId);
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
