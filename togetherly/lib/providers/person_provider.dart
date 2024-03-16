import 'dart:developer';

import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';

import 'package:togetherly/services/person_service.dart';
import 'base_provider.dart';

class PersonProvider extends BaseProvider {
  final PersonService service;
  final int personId;

  PersonProvider(this.service, this.personId) {
    log("PersonProvider created!");
    refresh();
  }

  List<Parent> _parentList = [];
  List<Parent> get parentList => _parentList;
  List<Child> _childList = [];
  List<Child> get childList => _childList;

  Future<void> addPerson(Person person) async {
    //figure out if it's a child or parent
    if(person is Child) {
      await service.insertChild(person);
    } else if( person is Parent) {
      await service.insertParent(person);
    }
    await refresh();
  }

  Future<void> deletePerson(Person person) async {
    await service.deletePerson(person);
    await refresh();
  }

  Future<void> updatePerson(Person person) async {
    if(person is Child) {
      await service.updateChild(person);
    } else if( person is Parent) {
      await service.updateParent(person);
    }
    await refresh();
  }

  //TODO: When do we need the refresh

  @override
  Future<void> refresh() async {
    _parentList = await service.getParents(1); // TODO: remove hardcode
    _childList = await service.getChildren(1); // TODO: remove hardcode
    notifyListeners();
    log("PersonProvider refreshed!");
  }
}
