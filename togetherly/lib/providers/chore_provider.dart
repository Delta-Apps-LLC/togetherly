import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_service.dart';

import '../models/child.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(
    this._choreService,
    this._assignmentService,
    this._userIdentityProvider,
  ) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService _choreService;
  final AssignmentService _assignmentService;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  List<Assignment> _allAssignments = [];
  List<Assignment> get allAssignments => _allAssignments;

  Map<int, Set<int>>? _choreIdToPersonIdsCache;
  Map<int, Set<int>> get _choreIdToPersonIds =>
      _choreIdToPersonIdsCache ??= _allAssignments.groupFoldBy(
          (a) => a.choreId, (prev, a) => (prev ?? <int>{})..add(a.personId));

  Map<int, Set<int>>? _personIdToChoreIdsCache;
  Map<int, Set<int>> get _personIdToChoreIds =>
      _personIdToChoreIdsCache ??= _allAssignments.groupFoldBy(
          (a) => a.personId, (prev, a) => (prev ?? <int>{})..add(a.choreId));

  Iterable<Chore> choresAssignedToPersonId(int personId) =>
      allChores.where((chore) =>
          (_personIdToChoreIds[personId] ?? const <int>{}).contains(chore.id));

  Iterable<int> personIdsAssignedToChore(Chore chore) =>
      _choreIdToPersonIds[chore.id] ?? const <int>{};

  Iterable<Chore> get choresAssignedToCurrentUser {
    int? personId = _userIdentityProvider.personId;
    return personId == null ? const [] : choresAssignedToPersonId(personId);
  }

  Future<void> addChore(Chore chore, List<int> assignedChildIds) async {
    final newChoreId = (await _choreService.insertChore(chore)).id;
    if (newChoreId == null) {
      throw Exception("Database did not return ID for new chore");
    }
    for (final childId in assignedChildIds) {
      await _assignmentService.insertAssignment(Assignment(
        personId: childId,
        choreId: newChoreId,
      ));
    }
    await refresh();
  }

  Future<void> deleteChore(Chore chore) async {
    await _choreService.deleteChore(chore);
    await refresh();
  }

  Future<void> updateChore(Chore chore, List<int>? assignedChildIds) async {
    await _choreService.updateChore(chore);
    if (assignedChildIds != null) {
      await updateChildrenAssignedToChore(chore, assignedChildIds);
    } else {
      await refresh();
    }
  }

  Future<void> updateChildrenAssignedToChore(
      Chore chore, List<int> assignedChildIds) async {
    final choreId = chore.id!;
    Set<int> previous = personIdsAssignedToChore(chore).toSet();
    Set<int> updated = assignedChildIds.toSet();

    Set<int> removed = previous.difference(updated);
    for (final childId in removed) {
      await _assignmentService.deleteAssignment(Assignment(
        personId: childId,
        choreId: choreId,
      ));
    }

    Set<int> added = updated.difference(previous);
    for (final childId in added) {
      await _assignmentService.insertAssignment(Assignment(
        personId: childId,
        choreId: choreId,
      ));
    }

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
      _allAssignments =
          await _assignmentService.getAssignmentsByFamily(familyId);
    } else {
      _allChores = [];
      _allAssignments = [];
    }
    _choreIdToPersonIdsCache = null;
    _personIdToChoreIdsCache = null;
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
