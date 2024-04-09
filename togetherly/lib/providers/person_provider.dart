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

  Person? _currentPerson;
  Person? get currentPerson => _currentPerson;

  bool _ready = false;
  bool get ready => _ready;

  Future<int?> addPerson(Person person) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      Person? person;
      if (person is Parent) {
        person = await _service.insertParent(person);
      } else if (person is Child) {
        person = await _service.insertChild(person);
      } else {
        throw Exception(
            'Cannot add a person that is neither a parent nor a child');
      }
      await refresh();
      return person?.id;
    } else {
      // TODO: Report some kind of error, possibly.
    }
    return null;
  }

  Future<void> deletePerson(Person person) async {
    await _service.deletePerson(person);
    await refresh();
  }

  Future<void> updatePerson(Person person) async {
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
    _ready = false;
    final familyId = _userIdentityProvider.familyId;
    final personId = _userIdentityProvider.personId;
    if (familyId != null) {
      _parents = await _service.getParents(familyId);
      _children = await _service.getChildren(familyId);
      _ready = true;
      if (personId != null) {
        _currentPerson = [...parents, ...children]
            .singleWhere((element) => element.id == personId);
      }
    } else {
      _parents = [];
      _children = [];
      _ready = true;
    }
    notifyListeners();
    log("PersonProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
