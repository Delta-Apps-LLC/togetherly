import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/child.dart';
import '../models/parent.dart';
import '../models/person.dart';

class PersonService {
  static const String _personTable = "person";

  Future<List<Person>> getParents(int familyId) async {
    var result = await Supabase.instance.client.from(_personTable)
        .select('id, familyid, name, profilepic, isParent')
        .match({
          'familyid': familyId,
          'isparent': true
        });

    return result.map(_mapToParent).toList();
  }

  Future<List<Person>> getChildren(int familyId) async {
    var result = await Supabase.instance.client.from(_personTable)
        .select('id, familyid, name, profilepic, isParent, totalpoints')
        .match({
      'familyid': familyId,
      'isparent': false
    });

    return result.map(_mapToChild).toList();
  }

  // Future<Person> getPerson(int personId) async {
  //   var result = await Supabase.instance.client.from(_personTable)
  //       .select('id, assignedPerson,title, description, dueDate, points, status')
  //       .match({ 'id': personId});
  //   // result might give a list of database rows
  //   var person;
  //   result.forEach((map) {
  //     person = Person(
  //         map['id'], map['personId'], map['title'], map['description'],map['dueDate'], map['points'], map['status'], map[shared]);
  //   });
  //
  //   return Future<Person>.value(person);
  //   // return Future<Person>.value();
  // }

  Future<void> insertParent(Parent parent) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from(_personTable)
        .insert({_parentToMap(parent)});
  }

  Future<void> insertChild(Child child) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from(_personTable)
        .insert({_childToMap(child)});
  }

  Future<void> deletePerson(Person person) async {
    //await
    await Supabase.instance.client
        .from(_personTable)
        .delete()
        .match({ 'id': person.id });
  }

  Future<void> updateChild(Child child) async {
    //Query by choreID
    await Supabase.instance.client
        .from(_personTable)
        .update(_childToMap(child))
        .match({ 'id': child.id });
  }

  Child _mapToChild(Map<String, dynamic> map) => Child(
      id: map['id'],
      familyId: map['familyId'],
      name: map['name'],
      icon: map['profilePic'],
      totalPoints: map['totalPoints']
  );

  Map<String, dynamic> _childToMap(Child child) => {
    'id': child.id,
    'familyid': child.familyId,
    'name': child.name,
    'isParent': false,
    'totalPoints': child.totalPoints,
    'profilepic': child.icon
  };

  Parent _mapToParent(Map<String, dynamic> map) => Parent(
      id: map['id'],
      familyId: map['familyId'],
      name: map['name'],
      icon: map['profilePic']
  );

  Map<String, dynamic> _parentToMap(Parent parent) => {
    'id': parent.id,
    'familyid': parent.familyId,
    'name': parent.name,
    'isParent': true,
    'profilepic': parent.icon
  };
}