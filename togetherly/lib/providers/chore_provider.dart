import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_completion_service.dart';
import 'package:togetherly/services/chore_service.dart';

import '../models/chore_completion.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(
    this._choreService,
    this._assignmentService,
    this._choreCompletionService,
    this._userIdentityProvider,
  ) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService _choreService;
  final AssignmentService _assignmentService;
  final ChoreCompletionService _choreCompletionService;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  Iterable<Chore> get allChores => _allChores;

  List<Assignment> _allAssignments = [];
  Iterable<Assignment> get allAssignments => _allAssignments;

  /// Cached copy of [_choreIdToPersonIds].
  Map<int, Set<int>>? _choreIdToPersonIdsCache;
  /// Helper map for getting the set of person IDs assigned to a chore.
  Map<int, Set<int>> get _choreIdToPersonIds =>
      _choreIdToPersonIdsCache ??= _allAssignments.groupFoldBy(
          (a) => a.choreId, (prev, a) => (prev ?? <int>{})..add(a.personId));

  /// Cached copy of [_personIdToChoreIds].
  Map<int, Set<int>>? _personIdToChoreIdsCache;
  /// Helper map for getting the set of chore IDs assigned to a person.
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

  /// Gets the status of the assignment of the given chore to the given person
  /// ID. Returns null if the chore is not assigned to the person ID.
  // TODO: Remove/update this once ChoreCompletion code is done.
  AssignmentStatus? getAssignmentStatus(Chore chore, int personId) =>
      _allAssignments
          .firstWhereOrNull(
              (a) => a.choreId == chore.id && a.personId == personId)
          ?.status;

  Future<void> addChore(Chore chore, [Iterable<int>? assignedChildIds]) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      final newChoreId = (await _choreService.insertChore(familyId, chore)).id;
      if (newChoreId == null) {
        throw Exception("Database did not return ID for new chore");
      }
      if (assignedChildIds != null) {
        for (final childId in assignedChildIds) {
          await _assignmentService.insertAssignment(Assignment(
            personId: childId,
            choreId: newChoreId,
          ));
        }
      }
      await refresh();
    } else {
      // TODO: Report some kind of error, possibly.
    }
  }

  Future<void> deleteChore(Chore chore) async {
    await _choreService.deleteChore(chore);
    await refresh();
  }

  Future<void> updateChore(Chore chore,
      [Iterable<int>? assignedChildIds]) async {
    await _choreService.updateChore(chore);
    if (assignedChildIds != null) {
      await updateChildrenAssignedToChore(chore, assignedChildIds);
    } else {
      await refresh();
    }
  }

  Future<void> addAssignment(Assignment assignment) async {
    await _assignmentService.insertAssignment(assignment);
    await refresh();
  }

  Future<void> deleteAssignment(Assignment assignment) async {
    await _assignmentService.deleteAssignment(assignment);
    await refresh();
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await _assignmentService.updateAssignment(assignment);
    if (assignment.status == AssignmentStatus.completed) {
      //TODO updated isApproved when adding parental approval functionality
      final chore = allChores.firstWhere((c) => c.id == assignment.choreId);
      await _choreCompletionService.insertChoreCompletion(ChoreCompletion(
        choreId: assignment.choreId,
        childId: assignment.personId,
        dateSubmitted: DateTime.now(),
        dueDate: chore.dueDate,
        isApproved: true,
      ));
    }
    await refresh();
  }

  Future<void> updateChildrenAssignedToChore(
      Chore chore, Iterable<int> assignedChildIds) async {
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
