import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_service.dart';

import '../models/child.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(this._choreService, this._assignmentService, this._userIdentityProvider) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService _choreService;
  final AssignmentService _assignmentService;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  // Iterable<Chore> choresAssignedToPerson(int personId)
  //   => allChores.where((chore) => chore.assignedChildId == personId);

  // Iterable<Chore>? get choresAssignedToCurrentUser {
  //   int? personId = _userIdentityProvider.personId;
  //   return personId == null ? null : choresAssignedToPerson(personId);
  // }

 /* List<Chore> getChoreByChild(int childId) {

  }*/
  Future<void> addChore(Chore chore, List<Child> children) async {
    //Will update to capture the chore when chore service is updated.
    await _choreService.insertChore(chore);
    for (final c in children) {
      Assignment assignment = Assignment(personId: c.id!, choreId: chore.id!);
      await _assignmentService.insertAssignment(assignment);
    }
    await refresh();
  }

  Future<void> deleteChore(Chore chore) async {
    await _choreService.deleteChore(chore);
    // for (final c in children) {
    //   Assignment assignment = Assignment(personId: c.id, choreId: chore.id!);
    //   await _assignmentService.deleteAssignment(assignment);
    // }
    await refresh();
  }

  Future<void> updateChore(Chore chore) async {
    await _choreService.updateChore(chore);
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
      _allChores = await _choreService.getChoresByFamily(familyId);
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
