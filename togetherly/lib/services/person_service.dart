import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/child.dart';
import '../models/parent.dart';
import '../models/person.dart';

class PersonService {
  static const String _personTable = "person";

  PersonService([SupabaseClient? supabaseClient])
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<List<Parent>> getParents(int familyId) async {
    var result = await _supabaseClient
        .from(_personTable)
        .select('id, family_id, pin, name, profile_pic, is_parent')
        .match({'family_id': familyId, 'is_parent': true});

    return result.map(_mapToParent).toList();
  }

  Future<List<Child>> getChildren(int familyId) async {
    var result = await _supabaseClient
        .from(_personTable)
        .select(
            'id, family_id, pin, name, profile_pic, is_parent, total_points')
        .match({'family_id': familyId, 'is_parent': false});

    return result.map(_mapToChild).toList();
  }

  Future<Parent> insertParent(Parent parent) async {
    return _mapToParent(
      (await _supabaseClient
              .from(_personTable)
              .insert(_parentToMap(parent))
              .select())
          .single,
    );
  }

  Future<Child> insertChild(Child child) async {
    return _mapToChild(
      (await _supabaseClient
              .from(_personTable)
              .insert(_childToMap(child))
              .select())
          .single,
    );
  }

  Future<void> deletePerson(Person person) async {
    await _supabaseClient.from(_personTable).delete().match({'id': person.id});
  }

  Future<void> updateChild(Child child) async {
    await _supabaseClient
        .from(_personTable)
        .update(_childToMap(child))
        .match({'id': child.id});
  }

  Future<void> updateParent(Parent parent) async {
    await _supabaseClient
        .from(_personTable)
        .update(_parentToMap(parent))
        .match({'id': parent.id});
  }

  Child _mapToChild(Map<String, dynamic> map) => Child(
        id: map['id'],
        familyId: map['family_id'],
        pin: map['pin'],
        name: map['name'],
        icon: _parseProfilePic(map['profile_pic']),
        totalPoints: map['total_points'],
      );

  Map<String, dynamic> _childToMap(Child child) => {
        'family_id': child.familyId,
        'pin': child.pin,
        'name': child.name,
        'is_parent': false,
        'profile_pic': _profilePicToString(child.icon),
        'total_points': child.totalPoints,
      };

  Parent _mapToParent(Map<String, dynamic> map) => Parent(
        id: map['id'],
        familyId: map['family_id'],
        pin: map['pin'],
        name: map['name'],
        icon: _parseProfilePic(map['profile_pic']),
      );

  Map<String, dynamic> _parentToMap(Parent parent) => {
        'family_id': parent.familyId,
        'pin': parent.pin,
        'name': parent.name,
        'is_parent': true,
        'profile_pic': _profilePicToString(parent.icon),
      };

  ProfileIcon _parseProfilePic(String pic) => switch (pic) {
        "bear" => ProfileIcon.bear,
        "cat" => ProfileIcon.cat,
        "chicken" => ProfileIcon.chicken,
        "dog" => ProfileIcon.dog,
        "fish" => ProfileIcon.fish,
        "fox" => ProfileIcon.fox,
        "giraffe" => ProfileIcon.giraffe,
        "gorilla" => ProfileIcon.gorilla,
        "koala" => ProfileIcon.koala,
        "panda" => ProfileIcon.panda,
        "rabbit" => ProfileIcon.rabbit,
        "tiger" => ProfileIcon.tiger,
        _ =>
          throw FormatException('Unsupported profile pic from database "$pic"'),
      };

  String _profilePicToString(ProfileIcon pic) => switch (pic) {
        ProfileIcon.bear => "bear",
        ProfileIcon.cat => "cat",
        ProfileIcon.chicken => "chicken",
        ProfileIcon.dog => "dog",
        ProfileIcon.fish => "fish",
        ProfileIcon.fox => "fox",
        ProfileIcon.giraffe => "giraffe",
        ProfileIcon.gorilla => "gorilla",
        ProfileIcon.koala => "koala",
        ProfileIcon.panda => "panda",
        ProfileIcon.rabbit => "rabbit",
        ProfileIcon.tiger => "tiger",
      };
}
