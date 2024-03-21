import 'package:supabase_flutter/supabase_flutter.dart';

class FamilyService {
  Future<String> getFamilyName(int familyId) async {
    var result = await Supabase.instance.client.from('family')
        .select('name')
        .match({ 'id': familyId });
    var name;
    result.forEach((map) {
      name =  map['name'];
    });

    return Future<String>.value(name);
  }

  Future<void> insertFamily(String name) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from('family')
        .insert({'name': name});
  }

  Future<void> deleteFamily(int familyId) async {
    //await
    await Supabase.instance.client
        .from('family')
        .delete()
        .match({ 'id': familyId });
  }

  Future<void> updateFamilyName(int familyId, String newName) async {
    //Query by choreID
    await Supabase.instance.client
        .from('family')
        .update({ 'name': newName })
        .match({ 'id': familyId });
  }
}