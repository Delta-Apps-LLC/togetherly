import 'dart:developer';

import 'package:collection/collection.dart';
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
  Iterable<Parent> get parents => _parents;

  List<Child> _children = [];
  Iterable<Child> get children => _children;

  Child? get currentChild => children
      .singleWhereOrNull((child) => child.id == _userIdentityProvider.personId);
  Parent? get currentParent => parents.singleWhereOrNull(
        (parent) => parent.id == _userIdentityProvider.personId);

  bool _ready = false;
  bool get ready => _ready;

  Future<void> addPerson(Person person) async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      if (person is Parent) {
        person = await _service.insertParent(person);
      } else if (person is Child) {
        person = await _service.insertChild(person);
      } else {
        throw Exception(
            'Cannot add a person that is neither a parent nor a child');
      }
      if (parents.isEmpty && children.isEmpty) {
        _userIdentityProvider.setPersonId(person.id);
      }
      await refresh();
    } else {
      throw Exception('Cannot add a person without the familyId');
    }
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
    notifyListeners();
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _parents = await _service.getParents(familyId);
      _children = await _service.getChildren(familyId);
    } else {
      _parents = [];
      _children = [];
    }
    _ready = true;
    notifyListeners();
    log("PersonProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
