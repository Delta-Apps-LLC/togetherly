import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/person_service.dart';

class PersonProvider with ChangeNotifier {
  PersonProvider(this._service, this._userIdentityProvider) {
    log("PersonProvider created");
    refresh();
  }

  final PersonService _service;
  UserIdentityProvider _userIdentityProvider;

  List<Parent> _parentList = [];
  List<Parent> get parentList => _parentList;
  List<Child> _childList = [];
  List<Child> get childList => _childList;

  Future<void> addPerson(Person person) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      person is Parent
          ? () async {
              final Parent parent = Parent(
                familyId: person.familyId,
                name: person.name,
                icon: person.icon,
              );
              await _service.insertParent(parent);
            }
          : person is Child
              ? () async {
                  final Child child = Child(
                      familyId: person.familyId,
                      name: person.name,
                      icon: person.icon,
                      totalPoints: 0);
                  await _service.insertChild(child);
                }
              : throw Exception('Invalid object for person insertion');
      await refresh();
    } else {
      // TODO: Report some kind of error, possibly.
    }
  }

  Future<void> deletePerson(Person person) async {
    await _service.deletePerson(person);
    await refresh();
  }

  Future<void> updatePerson(Person person, int newPoints) async {
    person is Parent
        ? () async {
            final Parent parent = Parent(
              familyId: person.familyId,
              name: person.name,
              icon: person.icon,
            );
            await _service.updateParent(parent);
          }
        : person is Child ? () async {
            final Child child = Child(
                familyId: person.familyId,
                name: person.name,
                icon: person.icon,
                totalPoints: newPoints);
            await _service.updateChild(child);
          } : throw Exception('Invalid object for person update');
    await refresh();
  }

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _parentList = await _service.getParents(familyId);
      _childList = await _service.getChildren(familyId);
    } else {
      _parentList = [];
      _childList = [];
    }
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
