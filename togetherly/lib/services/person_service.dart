import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/child.dart';
import '../models/parent.dart';
import '../models/person.dart';

class PersonService {
  static const String _personTable = "person";

  Future<List<Parent>> getParents(int familyId) async {
    var result = await Supabase.instance.client
        .from(_personTable)
        .select('id, family_id, name, profile_pic, is_parent')
        .match({'family_id': familyId, 'is_parent': true});

    return result.map(_mapToParent).toList();
  }

  Future<List<Child>> getChildren(int familyId) async {
    var result = await Supabase.instance.client
        .from(_personTable)
        .select('id, family_id, name, profile_pic, is_parent, total_points')
        .match({'family_id': familyId, 'is_parent': false});

    return result.map(_mapToChild).toList();
  }

  Future<void> insertParent(Parent parent) async {
    await Supabase.instance.client
        .from(_personTable)
        .insert({_parentToMap(parent)});
  }

  Future<void> insertChild(Child child) async {
    await Supabase.instance.client
        .from(_personTable)
        .insert({_childToMap(child)});
  }

  Future<void> deletePerson(Person person) async {
    await Supabase.instance.client
        .from(_personTable)
        .delete()
        .match({'id': person.id});
  }

  Future<void> updateChild(Child child) async {
    await Supabase.instance.client
        .from(_personTable)
        .update(_childToMap(child))
        .match({'id': child.id});
  }

  Child _mapToChild(Map<String, dynamic> map) => Child(
      id: map['id'],
      familyId: map['family_id'],
      name: map['name'],
      icon: map['profile_pic'],
      totalPoints: map['total_points']);

  Map<String, dynamic> _childToMap(Child child) => {
        'id': child.id,
        'family_id': child.familyId,
        'name': child.name,
        'is_parent': false,
        'total_points': child.totalPoints,
        'profile_pic': child.icon
      };

  Parent _mapToParent(Map<String, dynamic> map) => Parent(
      id: map['id'],
      familyId: map['family_id'],
      name: map['name'],
      icon: map['profile_pic']);

  Map<String, dynamic> _parentToMap(Parent parent) => {
        'id': parent.id,
        'family_id': parent.familyId,
        'name': parent.name,
        'is_parent': true,
        'profile_pic': parent.icon
      };
}
