import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/utilities/date.dart';

class ChoreProvider with ChangeNotifier {
  ChoreProvider(this._service, this._userIdentityProvider) {
    log("ChoreProvider created");
    refresh();
  }

  final ChoreService _service;

  UserIdentityProvider _userIdentityProvider;

  List<Chore> _allChores = [];
  List<Chore> get allChores => _allChores;

  List<Chore> get choreListDueToday => _allChores
      .where((chore) => chore.dueDate == DateHelpers.getDateToday())
      .toList();
  List<Chore> get choreListComingSoon =>
      _allChores.where((chore) => _isChoreDueTomorrow(chore.dueDate)).toList();
  List<Chore> get choreListOverdue =>
      _allChores.where((chore) => _isChoreOverdue(chore.dueDate)).toList();

  bool _isChoreDueTomorrow(DateTime dueDate) {
    final dateToday = DateHelpers.getDateToday();
    return dueDate.year == dateToday.year &&
        dueDate.month == dateToday.month &&
        dueDate.day == dateToday.day + 1;
  }

  bool _isChoreOverdue(DateTime dueDate) {
    final dateToday = DateHelpers.getDateToday();
    return dueDate.year <= dateToday.year &&
        dueDate.month <= dateToday.month &&
        dueDate.day < dateToday.day;
  }

  // Iterable<Chore> choresAssignedToPerson(int personId)
  //   => allChores.where((chore) => chore.assignedChildId == personId);

  // Iterable<Chore>? get choresAssignedToCurrentUser {
  //   int? personId = _userIdentityProvider.personId;
  //   return personId == null ? null : choresAssignedToPerson(personId);
  // }

  Future<void> addChore(Chore chore) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      await _service.insertChore(familyId, chore);
      await refresh();
    } else {
      // TODO: Report some kind of error, possibly.
    }
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
      _allChores = await _service.getChoresByFamily(familyId);
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
