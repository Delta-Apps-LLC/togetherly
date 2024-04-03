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

  List<Parent> _parents = [];
  List<Parent> get parents => _parents;

  List<Child> _children = [];
  List<Child> get children => _children;

  Future<void> addPerson(Person person) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      if (person is Parent) {
        await _service.insertParent(person);
      } else if (person is Child) {
        await _service.insertChild(person);
      } else {
        throw Exception(
            'Cannot add a person that is neither a parent nor a child');
      }
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
    if (person is Parent) {
      await _service.updateParent(person);
    } else if (person is Child) {
      await _service.updateChild(person);
    } else {
      throw Exception(
          'Cannot add a person that is neither a parent nor a child');
    }
    await refresh();
  }

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _parents = await _service.getParents(familyId);
      _children = await _service.getChildren(familyId);
    } else {
      _parents = [];
      _children = [];
    }
    notifyListeners();
    log("ChoreProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
