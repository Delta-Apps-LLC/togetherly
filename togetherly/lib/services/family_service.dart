import 'package:supabase_flutter/supabase_flutter.dart';

class FamilyService {
  Future<String> getFamilyName(int familyId) async {
    var result = await Supabase.instance.client.from('Person')
        .select('name')
        .match({ 'id': familyId });
    // result might give a list of database rows
    var name;
    result.forEach((map) {
      name =  map['name'];
    });

    return Future<String>.value(name);
  }

  Future<void> insertFamily(String name) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from('Family')
        .insert({
      'name': name
    });
  }

  Future<void> deleteFamily(int familyId) async {
    //await
    await Supabase.instance.client
        .from('Family')
        .delete()
        .match({ 'id': familyId });
  }

  Future<void> updateFamilyName(int familyId, String newName) async {
    //Query by choreID
    await Supabase.instance.client
        .from('Family')
        .update({ 'name': newName })
        .match({ 'id': familyId });
  }
}